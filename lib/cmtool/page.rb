module Cmtool
  module Page
    LAYOUTS = %w[application home contact manual]
    def self.included(klass)
      klass.send :include, SimplyStored::Couch

      # PROPERTIES
      klass.property :name
      klass.property :menu_text
      klass.property :title
      klass.property :body
      klass.property :footer
      klass.property :sidebar
      klass.property :priority, type: Float, default: 0.5
      klass.property :default, type: :boolean
      klass.property :active, type: :boolean, default: true
      klass.property :layout
      klass.property :in_menu, type: :boolean

      klass.has_ancestry :by_property => :locale

      klass.validates :name, presence: true
      klass.validates :locale, presence: true

      # RELATIONS
      klass.has_and_belongs_to_many :keywords, storing_keys: true, class_name: 'Cmtool::Keyword'

      # DEFAULT ORDER
      klass.view :all_documents, key: [:position, :name, :title]
      klass.view :by_name_and_locale, key: [:name, :locale]
    end
    def InstanceMethods

      def generate_name
        name = self.class.generate_name(title)
      end
    end

    def ClassMethods
      def generate_name(name)
        name.to_s.downcase.gsub(/^\W+/, '').gsub(/\W+$/,'').gsub(/\W+/, '-')
      end
      def active(*args)
        all(*args)
      end
    end
  end
end
