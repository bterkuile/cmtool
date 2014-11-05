require 'spec_helper'

describe Cmtool::PagesController, type: :controller do
  routes { Cmtool::Engine.routes }

  describe 'GET index' do
    it "should render standard view when tree is available" do
      create_pages_tree
      expect{ get :index }.not_to raise_error
    end
  end

end
