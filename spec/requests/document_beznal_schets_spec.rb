require 'spec_helper'

describe "DocumentBeznalSchets" do
  describe "GET /documents_beznal_schets" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get document_beznal_schets_path
      response.status.should be(200)
    end
  end
end
