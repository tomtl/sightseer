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
      it "creates the sight" do
        sight1 = Fabricate.attributes_for(:sight)
        post :create, sight: sight1
        expect(Sight.first.name).to eq(sight1[:name])
      end

      it "sets the success message" do
        sight1 = Fabricate.attributes_for(:sight)
        post :create, sight: sight1
        expect(flash[:success]).to be_present
      end

      it "redirects to sight_path" do
        sight1 = Fabricate.attributes_for(:sight)
        post :create, sight: sight1
        expect(response).to redirect_to(sight_path(Sight.first.id))
      end
    end

    context "with invalid inputs" do
      it "does not create the sight" do
        post :create, sight: { name: "Dude Ranch" }
        expect(Sight.count).to eq(0)
      end

      it "sets @sight" do
        post :create, sight: { name: "Dude Ranch" }
        expect(assigns(:sight)).to be_instance_of(Sight)
      end

      it "sets the error message" do
        post :create, sight: { name: "Dude Ranch" }
        expect(flash[:danger]).to be_present
      end

      it "renders the :create template" do
        post :create, sight: { name: "Dude Ranch" }
        expect(response).to render_template :new
      end
    end
  end

  describe "GET show" do
    it "sets @sight" do
      sight1 = Fabricate(:sight)
      get :show, id: sight1.id
      expect(assigns(:sight)).to eq(sight1)
    end
  end
end