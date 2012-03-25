module Cmtool
  class ContactForm
    include SimplyStored::Couch
    property :gender
    property :name
    property :email
    property :phone
    property :body
  end
end
