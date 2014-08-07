module Cmtool
  class ContactForm
    include SimplyStored::Couch
    property :gender
    property :name
    property :email
    property :phone
    property :body
    validates :email, presence: true
  end
end
