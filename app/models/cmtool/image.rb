module Cmtool
  class Image
    include SimplyCouch::Model
    # Paperclip → has_local_attached migration
    has_local_attached :file,
      styles: { page: '728x10000>', medium: '354x1000>', thumb: '160x1250>' },
      content_type: %w[image/jpeg image/gif image/png]
    validates :file_file_name, presence: true

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
