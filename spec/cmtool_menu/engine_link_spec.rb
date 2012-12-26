require 'spec_helper'

describe Cmtool::Menu::EngineLink do
  let(:options) { Hash.new }
  let(:link){ Cmtool::Menu::EngineLink.new(Cmtool::Engine, options)}
  subject{ link }

  its(:title) { should == 'Cmtool' }

  it 'Should change title when given as option' do
    options[:title] = 'Engine Title'
    link.title.should == 'Engine Title'
  end

  it "should change the path to internal path when given as symbol option" do
    options[:path] = :faqs
    link.path.should == '/cmtool/faqs'
  end

  it "should directly return a path specified as a string in the options" do
    options[:path] = 'http://www.google.com/'
    link.path.should == 'http://www.google.com/'
  end
end
