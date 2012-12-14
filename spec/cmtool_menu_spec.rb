require 'spec_helper'

describe Cmtool::Menu do
  before :all do
    @base_block = Cmtool::Menu.registrations.first
  end
  before :each do
    Cmtool::Menu.reset!
    Cmtool::Menu.register &@base_block
  end
  describe Cmtool::Menu::ElementBase do
    it "should return false on specific element inquiry" do
      base_element = Cmtool::Menu::ElementBase.new
      element_names = Cmtool::Menu::ElementBase.subclasses.map{|e| e.name.sub(/.*::/, '').underscore }
      for element_name in element_names
        base_element.send("#{element_name}?").should be_false
      end
    end
  end
  describe Cmtool::Menu::Group do
    it "should identify itself as such" do
      Cmtool::Menu::Group.new.group?.should be_true
    end
    it "should not identify as resource link" do
      Cmtool::Menu::Group.new.resource_link?.should be_false
    end
  end
  describe Cmtool::Menu::ResourceLink do
    it "should identify itself as such" do
      Cmtool::Menu::ResourceLink.new(User).resource_link?.should be_true
    end
  end
  describe :items do
    it "should return an array" do
      Cmtool::Menu.items.should be_a Array
    end
    it "should return an array of 5" do
      Cmtool::Menu.items.size.should == 5
    end

  end

  describe 'New register block' do
    before :each do
      Cmtool::Menu.register do
        before :users do
          resource_link Page, scope: Cmtool
        end
        after :publications do
          resource_link Cmtool::Image
        end

        append_to :publications do
          resource_link Cmtool::Directory
        end
      end
    end
    it "should have 7 items now" do
      Cmtool::Menu.items.size.should == 7
    end
    it "should have pages as second last items argument" do
      second_last = Cmtool::Menu.items[-2]
      second_last.should be_a Cmtool::Menu::ResourceLink
      second_last.resource.should == Page
    end

    it "should fall back to normal behaviour when no menu item specified is found" do
      Cmtool::Menu.reset!
      Cmtool::Menu.register do
        append_to :publications do
          resource_link Cmtool::Directory
        end
      end
      Cmtool::Menu.items.size.should == 1
    end
  end
end
