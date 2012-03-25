module Cmtool
  class Directory
    include SimplyStored::Couch
  
    property :name
  
    has_ancestry
  
    view :all_documents, key: :name
  
    has_many :images
  end
end
