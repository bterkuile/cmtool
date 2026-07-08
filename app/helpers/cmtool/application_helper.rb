module Cmtool
  module ApplicationHelper

    # Return the title of the application
    def application_title
      'Cmtool'
    end


    # Standard return content when empty listing is found
    # called with the model as argument
    #   = no_content_given Album
    def no_content_given(model)
      t('helpers.no_content_given', models: model.model_name.human_plural)
    end

    # overwrite i18n l, to handle nil values
    def l(*args, **options)
      return '' unless args.first
      super(*args, **options)
    end

    def site_title
      'Cmtool'
    end

    # Set the page title, allow setting a resource title like:
    #   - title :index, Album
    # or 
    #   - title :show, Album
    # or normal text behaviour:
    #   - title "Home"
    def title(*args)
      res = content_tag :h1, class: 'page-title' do
        if args.first.is_a?(Symbol) && (args[1].respond_to?(:model_name) || args[1].class.respond_to?(:model_name))
          model = args[1].respond_to?(:model_name) ? args[1] : args[1].class
          if args.first == :index
            t('cmtool.action.index.title', models: model.model_name.human_plural)
          else
            t("cmtool.action.#{args.first}.title", model: model.model_name.human)
          end
        else
          args.first
        end
      end
      content_for :page_title, res
      res
    end

    def are_you_sure(obj = nil)
      if name = obj && obj.respond_to?(:name) && obj.name.presence
        t('cmtool.general.are_you_sure_with_name', name: name, model: obj.class.model_name.human)
      else
        t('cmtool.general.are_you_sure')
      end
    end
    alias are_you_sure? are_you_sure

    def warnings
      @cmtool_warnings || []
    end

    def boolean_text(yes)
      ActiveModel::Type::Boolean.new.cast(yes) ? t('cmtool.general.yes') : t('cmtool.general.no')
    end
    def empty_result(model)
      t('cmtool.general.empty_result', models: model.model_name.human_plural.downcase )
    end
    def link_to_new_content(model)
      t('cmtool.action.new.title', model: model.model_name.human)
    end
    def link_to_edit_content(obj)
      t('cmtool.action.edit.title', model: obj.class.model_name.human)
    end
    def link_to_show_content(obj)
      t('cmtool.action.show.title', model: obj.class.model_name.human)
    end
    def link_to_index_content(model)
      t('cmtool.action.index.title', models: model.model_name.human_plural)
    end
    def link_to_destroy_content(obj)
      t('cmtool.action.destroy.title', model: obj.class.model_name.human)
    end

    def create_button_text(obj = nil)
      t('cmtool.action.create.label', model: obj ? obj.class.model_name.human : '')
    end
    def update_button_text(obj = nil)
      t('cmtool.action.update.label', model: obj ? obj.class.model_name.human : '')
    end
    def link_separator
      ' | '
    end
    def tree_options_for_select(roots, options = {})
      iterator = Proc.new do |add_to, elements|
        for element in elements
          if !options[:exclude].present? || (element.path_ids & Array.wrap(options[:exclude])).empty?
            add_to << ['- '*element.tree_depth + element.name, element.id]
            iterator.call(add_to, element.children) if element.children.any?
          end
        end
      end
      options_ary = []
      iterator.call(options_ary, roots)
      options_for_select(options_ary, options[:selected])
    end

    # This is a wrapper to create collapsible content. 
    def collapsible_content(options = {}, &blk)
      options = {title: options} if options.is_a?(String) # Single argument is title
      content = capture(&blk) if blk.present?
      content ||= options[:content]
      options[:collapsed] = true unless options.has_key?(:collapsed)
      classes = Array.wrap(options[:class]) | ["collapsible-container", options[:collapsed] ? 'collapsed' : nil]
      title_tag = content_tag(:div, "<span></span>#{options[:title]}".html_safe, class: 'collapsible-title')
      content_tag(:div, title_tag + content_tag(:div, content, class: 'collapsible-content'), class: classes)
    end

    def human_size(n)
      return '0 MB' unless n
      n = n.to_i
      count = 0
      while  n >= 1024 and count < 4
        n /= 1024.0
        count += 1
      end
      format("%.2f",n) + %w(B KB MB GB TB)[count]
    end

    # Add extra helper method since cmtool layouts may be used outside the cmtool scope
    def cmtool_user
      controller.respond_to?(:cmtool_user) ? controller.send(:cmtool_user) :nil
    end

    # Path prefixes matching how the consuming app's translations.js.coffee.erb
    # builds $translations: each top-level JS key is sourced from a different
    # Rails i18n scope. Keep in sync with that file.
    TSPAN_NAMESPACE_PREFIXES = {
      'models'     => 'activemodel.models',
      'attributes' => 'activemodel.attributes',
      'helpers'    => 'helpers',
      'pagination' => 'views.pagination',
      'errors'     => 'errors',
    }.freeze

    # Client-resolved translation span, mirroring the JS `tspan` helper in
    # translations.js.coffee.erb. Renders the raw (possibly ${...}-templated)
    # server-side translation as initial content, tagged with data-t so the
    # page's on-load JS can resolve nested ${...} references client-side.
    #   tspan 'attributes.supplier.name' # => <span data-t="attributes.supplier.name" class="translation">${models.supplier} name</span>
    def tspan(path, vars = {})
      namespace, rest = path.split('.', 2)
      prefix = TSPAN_NAMESPACE_PREFIXES.fetch(namespace, namespace)
      full_key = rest ? "#{prefix}.#{rest}" : prefix
      text = I18n.t(full_key, **vars)
      content_tag(:span, text, class: 'translation', data: { t: path, t_attributes: vars.to_json })
    end

    def edit_td(obj, options = {})
      path = options[:path] || case obj
        when Array then edit_polymorphic_path(obj)
        when SimplyCouch::Model then edit_polymorphic_path([options[:scope] || cmtool, obj])
        else obj
      end
      content_tag(
        :td,
        link_to(content_tag(:i, nil, class: 'write icon'), path, class: 'edit ui mini basic yellow icon button'),
        class: [:action, :edit]
      )
    end

    def destroy_td(obj, options = {})
      path = options[:path] || case obj
        when Array then polymorphic_path(obj)
        when SimplyCouch::Model then polymorphic_path([options[:scope] || cmtool, obj])
        else obj
      end

      content_tag(
        :td,
        link_to(content_tag(:i, nil, class: 'trash icon'), path, method: :delete, class: 'destroy ui mini negative icon button', data: {confirm: are_you_sure(obj) }),
        class: [:action, :destroy]
      )
    end
  end
end
