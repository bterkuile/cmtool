module Cmtool
   module Includes
     module PagesController
       extend ActiveSupport::Concern
        def home
          page_name = "home"
          @page = ::Page.find_by_name_and_locale(page_name, I18n.locale.to_s) || ::Page.new(:name => page_name, locale: I18n.locale.to_s)
          @sub_pages = @page.children.select{|child| child.in_menu.present? }
          render :template => "pages/#{page_name}", :layout => @page.layout.presence || ::Page.layouts.first.to_s
        end

        # General catcher for pages
        def show
          @page = ::Page.find_by_name_and_locale(params[:name], I18n.locale.to_s)
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
          @page = ::Page.find_by_name_and_locale('404', I18n.locale.to_s) || ::Page.new(name: '404', body: "404 Page Not Found")
          @sub_pages = []
          render template: 'pages/404', layout: @page.layout.presence || ::Page.layouts.first.to_s, status: 404
        end

        def sitemap
          respond_to do |format|
            format.xml do
              page_uris = ::Page.all.map{|p| page_path(p.name, locale: p.locale)}
              pages_xml = page_uris.map{|uri| "<url><loc>#{uri}</loc></url>"}.join("\n")
              result = <<-XML
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
#{pages_xml}
</urlset>
              XML
              render xml: result
            end
          end
        end
     end
   end
end
