require 'spec_helper'

describe Cmtool::ContactForm do

  it "is invalid with Funded.com in email or body" do
    build(:contact_form).should be_valid
    build(:contact_form, email: "fundingteam+url.com@getbusinessfunded.com").should_not be_valid
    build(:contact_form, body: "fundingteam+url.com@getbusinessFunded.com").should_not be_valid
  end
end
