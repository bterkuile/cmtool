module Cmtool
  class Quote
    include SimplyCouch::Model
    property :owner
    property :function
    property :state
    property :body
    property :active, type: :boolean, default: true
    property :locale

    # Paperclip → has_local_attached migration
    has_local_attached :image,
      styles: { medium: '300x1000>', thumb: '137x1250>' }

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
