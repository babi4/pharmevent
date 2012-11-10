require "spec_helper"

describe DocumentsNalPrihodsController do
  describe "routing" do

    it "routes to #index" do
      get("/documents_nal_prihods").should route_to("documents_nal_prihods#index")
    end

    it "routes to #new" do
      get("/documents_nal_prihods/new").should route_to("documents_nal_prihods#new")
    end

    it "routes to #show" do
      get("/documents_nal_prihods/1").should route_to("documents_nal_prihods#show", :id => "1")
    end

    it "routes to #edit" do
      get("/documents_nal_prihods/1/edit").should route_to("documents_nal_prihods#edit", :id => "1")
    end

    it "routes to #create" do
      post("/documents_nal_prihods").should route_to("documents_nal_prihods#create")
    end

    it "routes to #update" do
      put("/documents_nal_prihods/1").should route_to("documents_nal_prihods#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/documents_nal_prihods/1").should route_to("documents_nal_prihods#destroy", :id => "1")
    end

  end
end
