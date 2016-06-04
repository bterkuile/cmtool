module Cmtool
  class ContactForm
    include SimplyStored::Couch
    property :gender
    property :name
    property :email
    property :phone
    property :body
    validates :email, presence: true
    validate :if_there_are_bad_intentions

    private

    def if_there_are_bad_intentions
      has_bad_intentions = false
      has_bad_intentions = true if "#{email}#{body}" =~ /funded\.com/i
      errors.add(:base, :bad_intentions) if has_bad_intentions
    end
  end
end
