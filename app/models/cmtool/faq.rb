module Cmtool
  class Faq
    include SimplyStored::Couch

    property :question
    property :answer
    property :active, type: :boolean, default: true

    view :active_view, key: :created_at, conditions: "doc['active']"

    def self.active
      database.view(active_view)
    end

  end
end
