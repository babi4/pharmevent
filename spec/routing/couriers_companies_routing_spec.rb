require "spec_helper"

describe CouriersCompaniesController do
  describe "routing" do

    it "routes to #index" do
      get("/couriers_companies").should route_to("couriers_companies#index")
    end

    it "routes to #new" do
      get("/couriers_companies/new").should route_to("couriers_companies#new")
    end

    it "routes to #show" do
      get("/couriers_companies/1").should route_to("couriers_companies#show", :id => "1")
    end

    it "routes to #edit" do
      get("/couriers_companies/1/edit").should route_to("couriers_companies#edit", :id => "1")
    end

    it "routes to #create" do
      post("/couriers_companies").should route_to("couriers_companies#create")
    end

    it "routes to #update" do
      put("/couriers_companies/1").should route_to("couriers_companies#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/couriers_companies/1").should route_to("couriers_companies#destroy", :id => "1")
    end

  end
end
