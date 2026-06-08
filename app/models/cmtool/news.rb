module Cmtool
  class News
    include SimplyCouch::Model
    property :title
    property :active, type: :boolean, default: true
    property :date, type: Date
    property :body

    # Paperclip → has_local_attached migration
    has_local_attached :image,
      styles: { medium: '500x500>', thumb: '250x250>' }
    has_and_belongs_to_many :keywords, storing_keys: true
    validates :title, presence: true
    validates :date, presence: true

    view :all_documents, key: :date, descending: true
    view :by_active, key: [:active, :date], descending: true

    def self.active(options = {till: Date.today})
      find_all_by_active(true, options)
    end

    def self.find_all_by_active(active, options = {till: Date.today})
      database.view(by_active(startkey: [active, options[:till].strftime('%Y-%m-%d')], endkey: [active], descending: true))
    end
  end
end
