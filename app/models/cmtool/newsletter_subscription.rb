module Cmtool
  class NewsletterSubscription
    include SimplyStored::Couch
  
    # PROPERTIES
    property :email
    property :active, :type => :boolean, :default => true
    property :deactivation_token
  
    # CALLBACKS
    before_save :set_deactivation_token
  
    validates :email, presence: true, email: true

    def name
      email
    end
  
    private
  
    def set_deactivation_token
      self.deactivation_token = ((('a'..'z').to_a + ('A'..'Z').to_a)*100).sample(10).join
    end
  end
end
