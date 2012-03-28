module Cmtool
   module Includes
     module PagesController
        def home
          page_name = "home"
          @page = ::Page.find_by_name_and_locale(page_name, I18n.locale) || ::Page.new(:name => page_name, locale: I18n.locale)
          @sub_pages = @page.children.select{|child| child.in_menu.present? }
          render :template => "pages/#{page_name}", :layout => @page.layout.presence || ::Page.layouts.first.to_s
        end

        # General catcher for pages
        def show
          @page = ::Page.find_by_name_and_locale(params[:name], I18n.locale)
          not_found and return unless @page

          @sub_pages = [@page] + @page.children.select{|child| child.in_menu.present? }
          template = "pages/#{@page.name}"
          if template_exists?(template)
            render :template => template, :layout => @page.layout.presence || ::Page.layouts.first
            return
          else
            render :layout => @page.layout.presence || ::Page.layouts.first
          end
        end

        def not_found
          @page = ::Page.find_by_name_and_locale('404', I18n.locale) || ::Page.new(name: '404', body: "404 Page Not Found")
          @sub_pages = []
          render template: 'pages/404', layout: @page.layout.presence || ::Page.layouts.first.to_s, status: 404
        end
     end
   end
end
