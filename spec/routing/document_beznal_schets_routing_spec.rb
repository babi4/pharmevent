require "spec_helper"

describe DocumentBeznalSchetsController do
  describe "routing" do

    it "routes to #index" do
      get("/document_beznal_schets").should route_to("document_beznal_schets#index")
    end

    it "routes to #new" do
      get("/document_beznal_schets/new").should route_to("document_beznal_schets#new")
    end

    it "routes to #show" do
      get("/document_beznal_schets/1").should route_to("document_beznal_schets#show", :id => "1")
    end

    it "routes to #edit" do
      get("/document_beznal_schets/1/edit").should route_to("document_beznal_schets#edit", :id => "1")
    end

    it "routes to #create" do
      post("/document_beznal_schets").should route_to("document_beznal_schets#create")
    end

    it "routes to #update" do
      put("/document_beznal_schets/1").should route_to("document_beznal_schets#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/document_beznal_schets/1").should route_to("document_beznal_schets#destroy", :id => "1")
    end

  end
end
