module Cmtool
  class Quote
    include SimplyStored::Couch
    include Paperclip::Glue
    # TODO: Replace Paperclip with SimplyStored::HasAttachment
    # 1. Change `include Paperclip::Glue` to `include SimplyStored::HasAttachment`
    # 2. Replace `has_attached_file :image, styles: {...}` with `has_attachment :image, styles: {...}`

    property :owner
    property :function
    property :state
    property :body
    property :active, type: :boolean, default: true
    property :locale

    property :image_file_name
    property :image_content_type
    property :image_file_size, type: Integer
    property :image_updated_at, type: Time

    has_attached_file :image, styles: {medium: "300x1000>", thumb: "137x1250>" }

    view :for_sidebar_view, key: [:state, :created_at], conditions: %{doc['active']}
    STATES = %w[page sidebar]
    def self.active(*args)
      database.view(for_sidebar_view(*args))
    end

    def self.for_page
      active(startkey: ['page'], endkey: ['page', {}])
    end

    def self.states
      STATES
    end

    def self.for_sidebar
      active(startkey: ['sidebar'], endkey: ['sidebar', {}], limit: 2)
    end
  end
end
