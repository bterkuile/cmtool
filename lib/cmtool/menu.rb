module Cmtool
  module Menu
    def self.register(&block)
      @register ||= Register.new
      @register.instance_eval(&block)
      @registrations ||= []
      @registrations << block
    end

    def self.items
      @register.items
    end

    def self.method_missing(*args, &blk)
      @register.send(*args, &blk)
    end

    # Reset the complete menu
    def self.reset!
      @register = Register.new
      @registrations = []
    end

    # Getter for the registrations
    def self.registrations
      @registrations ||= []
    end

    ##
    # Base class for elements in the menu. All elements like Groups/ResourceLinks should
    # inherit from this class
    ##
    class ElementBase
      def initialize(*args)
        @options = args.extract_options!
      end
      def controller_names
        []
      end
      def controller_name
        ''
      end
      def options
        @options ||= {}
      end
      def method_missing(*args)
        return true if self.class.name.sub(/.*::/, '').underscore.concat("?") == args.first.to_s
        return false if args.first.to_s.last == '?'
        @register.send(*args)
      end

      def engine_link?
        false
      end

      def resource_link?
        false
      end

    end

    ##
    # Just a simple class that identifies itself as a divider
    ##
    class Divider < ElementBase
    end

    ##
    # A group element, works as a new kind of menu, but then within another one
    ##
    class Group < ElementBase
      def initialize(options = {}, &block)
        block ||= Proc.new{}
        @register = Register.new
        @options = options
        @block = block
        @register.instance_eval(&block)
      end

      def title
        @register.title.respond_to?(:call) ? @register.title.call : @register.title
      end

      def controller_names
        resource_links.map(&:controller_name)
      end
      def group?
        true
      end
    end

    ##
    # Engine link, links to an engine. Root by default
    ##
    class EngineLink < ElementBase
      attr_reader :engine
      def initialize(engine, options = {})
        @engine, @options = engine, options
      end

      def engine_link?
        true
      end


      def title
        options[:title] || engine.name.split('::').first
      end

      def path
        case options[:path]
        when Symbol then engine.routes.url_helpers.send(:"#{options[:path]}_path")
        when String then options[:path]
        else engine.routes.url_helpers.root_path
        end
      end
    end

    ##
    # Resource link, indicates a link to standard resource. The first argument should
    ##
    class ResourceLink < ElementBase
      attr_reader :resource
      def initialize(resource, options = {})
        @resource, @options = resource, options
      end

      def resource_link?
        true
      end

      def controller_name
        @resource.name.underscore.split('/').last.pluralize
      end
      def title
        @resource.model_name.human_plural
      end
      def path
        engine.routes.url_helpers.url_for({controller: nested_controller_name, action: 'index', only_path: true}.merge(@options[:path] || {}))
      end

      def engine
        return @options[:engine] if @options[:engine].present?
        if @options[:scope].present?
          base = options[:scope].to_s.camelize
        else
          base = @resource.name.split('::').first if @resource.name.index('::')
        end
        return Rails.application unless base
        return base if base.is_a?(Rails::Engine) # WTF?
        if e = "#{base}::Engine".safe_constantize
          return e
        end
        return Rails.application
      end

      def nested_controller_name
        if @options[:scope].present?
          "#{@options[:scope].to_s.camelize}::#{@resource.name.split('::').last}".underscore.pluralize
        else
          @resource.name.underscore.pluralize
        end
      end
    end

    ##
    # Register class on which the register blocks are executed. Should hold all possible DSL logic
    ##
    class Register
      attr_reader :items

      def initialize
        @items = []
      end

      def t(*args)
        -> { I18n.t(*args) }
      end

      def group(options = {}, &block)
        @items << Group.new(options, &block)
      end

      def title(*args)
        return @title if args.empty?
        @title = args.first
      end

      def resource_link(resource, options = {})
        @items << ResourceLink.new(resource, options)
      end

      def engine_link(engine, options = {})
        @items << EngineLink.new(engine, options)
      end

      def resource_links
        @items.select{|i| i.is_a?(ResourceLink)}
      end

      def method_missing(*args)
        @items.send(*args).to_a
      end

      def before(label, &block)
        @before = []
        @before << items.shift while items.first && items.first.options[:label] != label
        @after = @items
        @items = []
        instance_eval(&block)
        @items = @before + @items + @after
      end

      def after(label, &block)
        @before = []
        @before << items.shift while items.first && items.first.options[:label] != label
        @before << items.shift if items.any?
        @after = @items
        @items = []
        instance_eval(&block)
        @items = @before + @items + @after
      end

      def append_to(label, options = {}, &block)
        item = items.find{|i| i.options[:label] == label}
        if item
          register = item.instance_variable_get('@register')
          if register
            register.instance_variable_get('@items') << Cmtool::Menu::Divider.new unless options[:skip_divider].present?
            register.instance_eval(&block)
          end
        else
          instance_eval(&block)
        end
      end
    end
  end
end
