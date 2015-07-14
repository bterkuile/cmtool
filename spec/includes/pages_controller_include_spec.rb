require 'spec_helper'

describe PagesController, type: :controller do
  describe 'sitemap' do
    it 'returns a proper sitemap' do
      create_pages_tree
      get :sitemap, format: 'xml'
      response.body.should include "<loc>http://test.host/en/child2.2</loc>"
    end
  end
end
