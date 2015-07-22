require "spec_helper"

describe SightsController do
  describe "GET new" do
    it "sets @sight" do
      get :new
      expect(assigns(:sight)).to be_instance_of(Sight)
    end
  end

  describe "POST create" do
    context "with valid inputs" do
      it "creates the sight"
      it "sets the success message"

      it "redirects to sight_path" do
        sight1 = Fabricate.attributes_for(:sight)
        post :create, sight = sight1
        expect(response).to redirect_to(sight_path, id: Sight.first.id)
      end
    end

    context "with invalid inputs" do
      it "does not create the sight"
      it "sets @sight"
      it "sets the error message"
      it "renders the :create template"
    end
  end
end