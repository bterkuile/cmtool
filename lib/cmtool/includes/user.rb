module Cmtool
  module Includes
    module User
      def self.included(klass)
        klass.send :include, SimplyStored::Couch
        #klass.send :include, Devise::Orm::SimplyStored
        klass.send :include, InstanceMethods
        klass.send :extend, ClassMethods

        klass.property :is_admin, type: :boolean
        klass.property :active, type: :boolean, default: true


        #== VALIDATIONS
        klass.validates_presence_of :email
        klass.validates_uniqueness_of :email, if: lambda{ |u| u.email.present? }
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
          @generated_password = self.class.password_haystack.sample(8).join
          self.password = @generated_password
          self.password_confirmation = @generated_password
        end
      end

      module ClassMethods
        def password_haystack
          @password_haystack ||= (:a..:z).to_a + (:A..:Z).to_a + (0..9).to_a
        end
      end
    end
  end
end
