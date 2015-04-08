require 'spec_helper'

describe Cmtool::YmlFile do
  describe ".all_as_object" do
    it "combines the files using deep merge" do
      described_class.create body: <<-YML.strip_heredoc
      nl:
        android:
          link: <a>l</a>
      YML
      described_class.create body: <<-YML.strip_heredoc
      nl:
        android:
          title: Mozo at Play store
      YML

      result = described_class.all_as_object
      result.should =~ {
        "nl"=> {
          "android" => {
            "title"=>"Mozo at Play store",
            "link"=>"<a>l</a>"
          }
        }
      }
    end
  end
end
