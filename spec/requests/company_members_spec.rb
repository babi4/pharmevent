require 'spec_helper'

describe "CompanyMembers" do
  describe "GET /company_members" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get company_members_path
      response.status.should be(200)
    end
  end
end
