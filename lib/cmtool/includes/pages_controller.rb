module Cmtool
  module Includes
    module PagesController
      extend ActiveSupport::Concern

      def home
        page_name = 'home'
        @page = find_page(page_name)
        @sub_pages = @page.children.select{|child| child.in_menu.present? }
        render template: "pages/#{page_name}", layout: @page.layout.presence || ::Page.layouts.first.to_s, formats: [:html]
      end

      # General catcher for pages
      def show
        @page = ::Page.find_by_name_and_locale(params[:name], I18n.locale.to_s)
        return not_found  unless @page

        @sub_pages = [@page] + @page.children.select{|child| child.in_menu.present? }
        template = "pages/#{@page.name}"
        if template_exists?(template)
          render template: template, formats: [:html], layout: @page.layout.presence || ::Page.layouts.first
          return
        else
          render formats: [:html], layout: @page.layout.presence || ::Page.layouts.first
        end
      end

      def not_found
        @page = ::Page.find_by_name_and_locale('404', I18n.locale.to_s) || ::Page.new(name: '404', body: "404 Page Not Found")
        @sub_pages = []
        page_name_extension = params[:name].to_s[/(?<=\.)\w{2,4}$/]
        format = %w[html css js json].find{|f| f == request.format.symbol.to_s or f == page_name_extension }.try(:to_sym) || :html
        case format
        when :json
          render json: {}, status: 404
        when :html
          render template: 'pages/404', formats: [:html], layout: @page.layout.presence || ::Page.layouts.first.to_s, status: 404
        else
          render nothing: true, status: 404
        end
      end

      def sitemap
        respond_to do |format|
          format.xml do
            pages_xml = ::Page.for_sitemap.map do |page|
              uri = page_url(page.name, locale: page.locale)
              "<url><loc>#{uri}</loc><lastmod>#{page.updated_at.strftime('%Y-%m-%d')}</lastmod></url>"
            end.join("\n")
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

      private

      def find_page(name)
        ::Page.find_by_name_and_locale(name, I18n.locale.to_s) || ::Page.new(name: name, locale: I18n.locale.to_s)
      end
    end
  end
end
