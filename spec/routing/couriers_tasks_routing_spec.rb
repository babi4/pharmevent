require "spec_helper"

describe CouriersTasksController do
  describe "routing" do

    it "routes to #index" do
      get("/couriers_tasks").should route_to("couriers_tasks#index")
    end

    it "routes to #new" do
      get("/couriers_tasks/new").should route_to("couriers_tasks#new")
    end

    it "routes to #show" do
      get("/couriers_tasks/1").should route_to("couriers_tasks#show", :id => "1")
    end

    it "routes to #edit" do
      get("/couriers_tasks/1/edit").should route_to("couriers_tasks#edit", :id => "1")
    end

    it "routes to #create" do
      post("/couriers_tasks").should route_to("couriers_tasks#create")
    end

    it "routes to #update" do
      put("/couriers_tasks/1").should route_to("couriers_tasks#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/couriers_tasks/1").should route_to("couriers_tasks#destroy", :id => "1")
    end

  end
end
