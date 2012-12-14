require 'spec_helper'

describe Page do
  before :each do
        @nl1 = create :page, name: 'nl1', locale: 'nl'
        @nl11 = create :page, name: 'nl11', locale: 'nl', parent_id: @nl1.id
        @nl111 = create :page, name: 'nl111', locale: 'nl', parent_id: @nl11.id
        @nl12 = create :page, name: 'nl12', locale: 'nl', parent_id: @nl1.id

        @en1 = create :page, name: 'en1', locale: 'en'
  end

  describe :ancestry do
    it "should not be valid when the parent has a different locale then the page itself" do
      @nl12.parent_id = @en1.id
      @nl12.should_not be_valid
      @nl12.error_on(:locale).should_not be_empty
    end
  end

end
