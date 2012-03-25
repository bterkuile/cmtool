module Cmtool
  class Keyword
    include SimplyStored::Couch
  
    property :name
  
    has_and_belongs_to_many :pages, storing_keys: false, class_name: 'Page'
    has_and_belongs_to_many :news, :storing_keys => false
  end
end
