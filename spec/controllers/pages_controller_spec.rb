require 'spec_helper'

describe Cmtool::PagesController do
  describe 'GET index' do
    it "should render standard view when tree is available" do
      #binding.pry
      create_pages_tree
      ->{ get :index }.should_not raise_error
    end
  end


end
