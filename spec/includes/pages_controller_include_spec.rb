require 'spec_helper'

class TestPagesController < ApplicationController
  include Cmtool::Includes::PagesController
end

describe TestPagesController, type: :controller do
  describe 'sitemap' do
        it 'returns a proper sitemap' do
          create_pages_tree
          get :sitemap, format: 'xml'
          expect( response.body ).to include "<url><loc>/en/child2.2</loc></url>"
        end
  end
end
