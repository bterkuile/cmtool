module Cmtool
  module ApplicationHelper

    def site_title
      'Cmtool'
    end
    def title(*args)
      content_for :title do
        if args.first.is_a?(Symbol) && (args[1].respond_to?(:model_name) || args[1].class.respond_to?(:model_name))
          model = args[1].respond_to?(:model_name) ? args[1] : args[1].class
          if args.first == :index
            t('cmtool.action.index.title', models: model.model_name.human_plural)
          else
            t("cmtool.action.#{args.first}.title", model: model.model_name.human)
          end
        else
          raise 'Imporoper title declaration'
          args.first
        end
      end
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
      @cmtool_warnings
    end

    def boolean_text(yes)
      yes.present? ? t('cmtool.general.yes') : t('cmtool.general.no')
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

    def create_button_text(obj)
      t('cmtool.action.create.label', model: obj.class.model_name.human)
    end
    def update_button_text(obj)
      t('cmtool.action.update.label', model: obj.class.model_name.human)
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

    def edit_td(obj)
      content_tag(
        :td, 
        link_to((content_tag(:span, 'edit', class: ['ui-icon', 'ui-icon-pencil'])), cmtool.url_for([:edit, obj]), class: [:edit]), 
        class: [:action, :edit]
      )
    end
    def destroy_td(obj)
      content_tag(
        :td, 
        link_to(content_tag(:span, 'delete', class: ['ui-icon', 'ui-icon-trash']), cmtool.url_for(obj), method: :delete, confirm: are_you_sure(obj), class: [:destroy]),
        class: [:action, :destroy]
      )
    end
  end
end
