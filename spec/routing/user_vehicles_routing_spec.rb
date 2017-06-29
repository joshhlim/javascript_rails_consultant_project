require "spec_helper"

describe UserVehiclesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get("/garage")).to route_to("user_vehicles#index")
    end

    it "routes to #new" do
      expect(get("/garage/new")).to route_to("user_vehicles#new")
    end

    it "routes to #show" do
      expect(get("/garage/1")).to route_to("user_vehicles#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/garage/1/edit")).to route_to("user_vehicles#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post("/garage")).to route_to("user_vehicles#create")
    end

    it "routes to #update" do
      expect(put("/garage/1")).to route_to("user_vehicles#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/garage/1")).to route_to("user_vehicles#destroy", :id => "1")
    end

  end
end
