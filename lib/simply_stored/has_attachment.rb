# frozen_string_literal: true

module SimplyStored
  # Drop-in replacement for Paperclip in SimplyStored/CouchDB models.
  #
  # Usage (replaces `include Paperclip::Glue` + `has_attached_file`):
  #
  #   class Image
  #     include SimplyStored::Couch
  #     include SimplyStored::HasAttachment
  #
  #     has_attachment :file, styles: {
  #       medium: "354x1000>",
  #       thumb:  "160x1250>"
  #     }
  #
  #     # Validations (standard Rails, replaces validates_attachment)
  #     validate :file_content_type_must_be_image
  #
  #     private
  #
  #     def file_content_type_must_be_image
  #       return if file.blank?
  #       unless %w[image/jpeg image/gif image/png].include?(file_content_type)
  #         errors.add(:file, :invalid_content_type)
  #       end
  #     end
  #   end
  #
  # The module auto-declares CouchDB properties for:
  #   <name>_file_name, <name>_content_type, <name>_file_size, <name>_updated_at
  #
  # Files are stored on disk at:
  #   public/system/<attachment>/<id>/original.<ext>
  #   public/system/<attachment>/<id>/<style>.<ext>
  #
  # Uses MiniMagick (ImageMagick) for thumbnail generation.
  # Same geometry syntax as Paperclip: "300x300>", "160x1250>", etc.
  module HasAttachment
    def self.included(base)
      base.extend(ClassMethods)
    end

    # Proxy object returned by attachment getters (e.g. `image.file`).
    # Mimics the Paperclip::Attachment API that views expect.
    class Proxy
      def initialize(record, name)
        @record = record
        @name = name
      end

      def present?
        @record.send(:"#{@name}_file_name").present?
      end

      def blank?
        !present?
      end

      def url(style = nil)
        @record.send(:"#{@name}_url", style)
      end

      def original_filename
        @record.send(:"#{@name}_file_name")
      end

      def content_type
        @record.send(:"#{@name}_content_type")
      end

      def size
        @record.send(:"#{@name}_file_size")
      end

      # Delegate anything else to the record
      def method_missing(method, *args, &block)
        if @record.respond_to?(method, true)
          @record.send(method, *args, &block)
        else
          super
        end
      end

      def respond_to_missing?(method, include_private = false)
        @record.respond_to?(method, include_private) || super
      end
    end

    module ClassMethods
      def has_attachment(name, styles: {}, default_url: nil, default_style: :original)
        # Auto-declare CouchDB properties for attachment metadata
        property :"#{name}_file_name"
        property :"#{name}_content_type"
        property :"#{name}_file_size", type: Integer
        property :"#{name}_updated_at", type: Time

        # Register configuration
        attachment_registry[name] = {
          styles: styles,
          default_url: default_url,
          default_style: default_style,
        }

        # ---- Setter: model.file = uploaded_file ----
        define_method(:"#{name}=") do |uploaded|
          # Handle clearing: nil, empty string
          if uploaded.nil? || (uploaded.respond_to?(:empty?) && uploaded.empty?)
            send(:"#{name}_file_name=", nil)
            send(:"#{name}_content_type=", nil)
            send(:"#{name}_file_size=", nil)
            send(:"#{name}_updated_at=", nil)
            return
          end

          config = self.class.attachment_registry[name]

          # Extract file info
          original_filename = if uploaded.respond_to?(:original_filename)
                                uploaded.original_filename
                              elsif uploaded.respond_to?(:path)
                                File.basename(uploaded.path)
                              else
                                "file"
                              end
          ext = File.extname(original_filename)
          ext = ".bin" if ext.blank?

          content_type = uploaded.respond_to?(:content_type) ? uploaded.content_type : nil
          file_size    = uploaded.respond_to?(:size) ? uploaded.size : nil

          # Read content (handle multiple upload types)
          content = if uploaded.respond_to?(:read)
                      data = uploaded.read
                      uploaded.rewind if uploaded.respond_to?(:rewind)
                      data
                    elsif uploaded.respond_to?(:path) && File.exist?(uploaded.path)
                      File.binread(uploaded.path)
                    elsif uploaded.respond_to?(:tempfile)
                      uploaded.tempfile.read
                    else
                      uploaded.to_s
                    end

          # Build storage path
          record_id = respond_to?(:id) && id.present? ? id.to_s : "tmp"
          base_dir = Rails.root.join("public", "system", name.to_s, record_id)
          FileUtils.mkdir_p(base_dir)

          begin
            # Write original file
            original_path = base_dir.join("original#{ext}")
            File.binwrite(original_path, content)

            # Generate thumbnail styles
            config[:styles].each do |style_name, geometry|
              style_path = base_dir.join("#{style_name}#{ext}")
              begin
                image = MiniMagick::Image.open(original_path.to_s)
                image.resize(geometry)
                image.write(style_path.to_s)
              rescue StandardError => e
                # If ImageMagick fails, copy original as fallback
                Rails.logger.warn(
                  "[HasAttachment] Could not generate #{style_name} for #{name}: #{e.message}"
                )
                FileUtils.cp(original_path, style_path)
              end
            end

            # Store metadata as CouchDB properties
            send(:"#{name}_file_name=", original_filename)
            send(:"#{name}_content_type=", content_type)
            send(:"#{name}_file_size=", file_size || content.bytesize)
            send(:"#{name}_updated_at=", Time.current)
          rescue StandardError => e
            errors.add(name, "could not be processed: #{e.message}")
            Rails.logger.error("[HasAttachment] Error processing #{name}: #{e.message}")
          end
        end

        # ---- Getter: model.file → Proxy ----
        define_method(name) do
          Proxy.new(self, name)
        end

        # ---- URL helper: model.file_url(:thumb) ----
        define_method(:"#{name}_url") do |style_name = nil|
          config = self.class.attachment_registry[name]
          style_name ||= config[:default_style]

          fname = send(:"#{name}_file_name")
          if fname.blank?
            return config[:default_url] if config[:default_url]
            return nil
          end

          ext = File.extname(fname)
          record_id = respond_to?(:id) && id.present? ? id.to_s : "tmp"

          "/system/#{name}/#{record_id}/#{style_name}#{ext}"
        end

        # ---- Backward compat: *_path for Paperclip migrations ----
        define_method(:"#{name}_path") do |style_name = nil|
          config = self.class.attachment_registry[name]
          style_name ||= config[:default_style]

          fname = send(:"#{name}_file_name")
          return nil if fname.blank?

          ext = File.extname(fname)
          record_id = respond_to?(:id) && id.present? ? id.to_s : "tmp"

          Rails.root.join("public", "system", name.to_s, record_id, "#{style_name}#{ext}").to_s
        end
      end

      # Registry of all attachments defined on this class
      def attachment_registry
        @_has_attachment_registry ||= {}
      end
    end
  end
end
