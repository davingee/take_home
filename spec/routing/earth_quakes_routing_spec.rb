require "rails_helper"

RSpec.describe EarthQuakesController, type: :routing do
  describe "routing" do

    it "routes to root path" do
      expect(:get => "/").to route_to("earth_quakes#index")
    end

  end
end
