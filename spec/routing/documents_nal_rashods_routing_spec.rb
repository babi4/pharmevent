require "spec_helper"

describe DocumentsNalRashodsController do
  describe "routing" do

    it "routes to #index" do
      get("/documents_nal_rashods").should route_to("documents_nal_rashods#index")
    end

    it "routes to #new" do
      get("/documents_nal_rashods/new").should route_to("documents_nal_rashods#new")
    end

    it "routes to #show" do
      get("/documents_nal_rashods/1").should route_to("documents_nal_rashods#show", :id => "1")
    end

    it "routes to #edit" do
      get("/documents_nal_rashods/1/edit").should route_to("documents_nal_rashods#edit", :id => "1")
    end

    it "routes to #create" do
      post("/documents_nal_rashods").should route_to("documents_nal_rashods#create")
    end

    it "routes to #update" do
      put("/documents_nal_rashods/1").should route_to("documents_nal_rashods#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/documents_nal_rashods/1").should route_to("documents_nal_rashods#destroy", :id => "1")
    end

  end
end
