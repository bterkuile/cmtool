module Cmtool
  class Image
    include SimplyStored::Couch
    include Paperclip::Glue

    property :file_file_name
    property :file_content_type
    property :file_file_size, type: Integer
    property :file_updated_at, type: Time
    has_attached_file :file, styles: { page: '728x10000>', medium: "354x1000>", thumb: "160x1250>" },
      path: ":rails_root/public/system/:attachment/:id/:style.:extension",
      url: "/system/:attachment/:id/:style.:extension"
   validates_attachment :file, presence: true, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }

    belongs_to :directory

    def self.active(*args)
      all(*args)
    end

    # Return cleaned name, without extension
    def clean_name
      return file_file_name
      file_file_name.to_s.sub(/\..*/, '')
    end
  end
end
