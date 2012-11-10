require "spec_helper"

describe CompanyMembersController do
  describe "routing" do

    it "routes to #index" do
      get("/company_members").should route_to("company_members#index")
    end

    it "routes to #new" do
      get("/company_members/new").should route_to("company_members#new")
    end

    it "routes to #show" do
      get("/company_members/1").should route_to("company_members#show", :id => "1")
    end

    it "routes to #edit" do
      get("/company_members/1/edit").should route_to("company_members#edit", :id => "1")
    end

    it "routes to #create" do
      post("/company_members").should route_to("company_members#create")
    end

    it "routes to #update" do
      put("/company_members/1").should route_to("company_members#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/company_members/1").should route_to("company_members#destroy", :id => "1")
    end

  end
end
