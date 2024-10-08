require "rails_helper"

RSpec.describe QualityProjectsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/quality_projects").to route_to("quality_projects#index")
    end

    it "routes to #new" do
      expect(get: "/quality_projects/new").to route_to("quality_projects#new")
    end

    it "routes to #show" do
      expect(get: "/quality_projects/1").to route_to("quality_projects#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/quality_projects/1/edit").to route_to("quality_projects#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/quality_projects").to route_to("quality_projects#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/quality_projects/1").to route_to("quality_projects#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/quality_projects/1").to route_to("quality_projects#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/quality_projects/1").to route_to("quality_projects#destroy", id: "1")
    end
  end
end
