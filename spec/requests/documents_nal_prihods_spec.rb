require 'spec_helper'

describe "DocumentsNalPrihods" do
  describe "GET /documents_nal_prihods" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get documents_nal_prihods_path
      response.status.should be(200)
    end
  end
end
