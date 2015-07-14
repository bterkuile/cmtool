require 'spec_helper'

feature 'sitemap.xml' do
  scenario 'proper sitemap' do
    p1 = Page.create name: 'nl-1', title: 'NL 1', locale: 'nl'
    p1 = Page.create name: 'en-1', title: 'EN 1', locale: 'en'
    visit "/sitemap.xml"
    page.body.should include "<lastmod>#{Date.today.strftime('%Y-%m-%d')}</lastmod>"
    page.body.should include "<loc>/en/en-1</loc>"
    page.body.should include "<loc>/nl-1</loc>"
  end
end
