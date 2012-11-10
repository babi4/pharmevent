require 'spec_helper'

describe "DocumentsBeznalRashods" do
  describe "GET /documents_beznal_rashods" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get documents_beznal_rashods_path
      response.status.should be(200)
    end
  end
end
