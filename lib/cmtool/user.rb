module Cmtool
  module User
    def self.included(klass)
      klass.extend Devise::Models
      klass.send :include, SimplyStored::Couch
      klass.send :include, Devise::Orm::SimplyStored
      klass.send :include, InstanceMethods

      klass.property :employee_email
      klass.property :is_admin, type: :boolean
      klass.property :active, type: :boolean, default: true

      klass.devise :database_authenticatable, :recoverable, :rememberable, :trackable


      #== VALIDATIONS
      klass.validates_presence_of :email
      klass.validates_uniqueness_of :email
      klass.validates_presence_of :encrypted_password, if: lambda{ |u| u.email.present? }
      klass.validates_confirmation_of :password, if: lambda{ |u| u.password.present? }
  

      klass.view :by_email, key: :email
    end
    module InstanceMethods
      def google?
        false
      end
      def name
        email
      end

      def generated_password
        @generated_password
      end

      def generate_password!
        @password_haystack ||= (:a..:z).to_a + (:A..:Z).to_a + (0..9).to_a
        @generated_password = @password_haystack.sample(8).join
        self.password = @generated_password
        self.password_confirmation = @generated_password
      end
    end
  end
end
