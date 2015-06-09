module Cmtool
  class YmlFile
    include SimplyStored::Couch

    property :name
    property :body
    property :position

    def self.all_as_object
      all.each.with_object Hash.new do |yml_file, obj|
        yml_obj = YAML.load(yml_file.body) rescue nil
        obj.deep_merge!( yml_obj ) if yml_obj
      end
    end
  end
end
