require "spec_helper"

describe MoleculesController do
  describe "routing" do

    it "routes to #index" do
      get("/molecules").should route_to("molecules#index")
    end

    it "routes to #new" do
      get("/molecules/new").should route_to("molecules#new")
    end

    it "routes to #show" do
      get("/molecules/1").should route_to("molecules#show", :id => "1")
    end

    it "routes to #edit" do
      get("/molecules/1/edit").should route_to("molecules#edit", :id => "1")
    end

    it "routes to #create" do
      post("/molecules").should route_to("molecules#create")
    end

    it "routes to #update" do
      put("/molecules/1").should route_to("molecules#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/molecules/1").should route_to("molecules#destroy", :id => "1")
    end

  end
end
