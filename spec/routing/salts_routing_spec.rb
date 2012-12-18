require "spec_helper"

describe SaltsController do
  describe "routing" do

    it "routes to #index" do
      get("/salts").should route_to("salts#index")
    end

    it "routes to #new" do
      get("/salts/new").should route_to("salts#new")
    end

    it "routes to #show" do
      get("/salts/1").should route_to("salts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/salts/1/edit").should route_to("salts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/salts").should route_to("salts#create")
    end

    it "routes to #update" do
      put("/salts/1").should route_to("salts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/salts/1").should route_to("salts#destroy", :id => "1")
    end

  end
end
