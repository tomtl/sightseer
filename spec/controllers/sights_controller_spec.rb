require "spec_helper"

describe SightsController do
  describe "GET new" do
    it "sets @sight" do
      set_current_user
      get :new
      expect(assigns(:sight)).to be_instance_of(Sight)
    end

    it_behaves_like "requires sign in" do
      let(:action) { get :new }
    end
  end

  describe "POST create" do
    it_behaves_like "requires sign in" do
      let(:action) { post :create }
    end

    context "with valid inputs" do
      let(:sight1) { Fabricate.attributes_for(:sight) }
      before do
        set_current_user
        post :create, sight: sight1
      end

      it "creates the sight" do
        expect(Sight.first.name).to eq(sight1[:name])
      end

      it "sets the success message" do
        expect(flash[:success]).to be_present
      end

      it "redirects to sight_path" do
        expect(response).to redirect_to(sight_path(Sight.first.id))
      end
    end

    context "with invalid inputs" do
      before do
        set_current_user
        post :create, sight: { name: "Dude Ranch" }
      end

      it "does not create the sight" do
        expect(Sight.count).to eq(0)
      end

      it "sets @sight" do
        expect(assigns(:sight)).to be_instance_of(Sight)
      end

      it "sets the error message" do
        expect(flash[:danger]).to be_present
      end

      it "renders the :create template" do
        expect(response).to render_template :new
      end
    end
  end

  describe "GET index" do
    it "sets @sights" do
      sight1 = Fabricate(:sight)
      sight2 = Fabricate(:sight)
      get :index
      expect(assigns(:sights)).to include(sight1, sight2)
    end
  end

  describe "GET show" do
    it "sets @sight" do
      sight1 = Fabricate(:sight)
      get :show, id: sight1.id
      expect(assigns(:sight)).to eq(sight1)
    end
  end

  describe "GET edit" do
    it "sets @sight" do
      set_current_user
      sight1 = Fabricate(:sight)
      get :edit, id: sight1.id
      expect(assigns(:sight)).to eq(sight1)
    end

    it_behaves_like "requires sign in" do
      let(:action) { get :edit, id: 1 }
    end
  end

  describe "PATCH update" do
    it_behaves_like "requires sign in" do
      let(:action) { patch :update, id: 1 }
    end

    context "with valid inputs" do
      let(:sight1) { Fabricate(:sight) }

      before do
        set_current_user
        patch :update, id: sight1.id, sight: { name: "Bob's House" }
      end

      it "updates the sight" do
        expect(Sight.first.name).to eq("Bob's House")
      end

      it "sets the success message" do
        expect(flash[:success]).to be_present
      end

      it "redirects to the sight page" do
        expect(response).to redirect_to(sight_path(sight1))
      end
    end

    context "with invalid inputs" do
      let(:sight1) { Fabricate(:sight) }
      before do
        set_current_user
        patch :update, id: sight1.id, sight: { name: nil }
      end

      it "does not update the sight" do
        expect(Sight.first.name).to eq(sight1.name)
      end

      it "sets the error message" do
        expect(flash[:danger]).to be_present
      end

      it "renders the :edit template" do
        expect(response).to render_template :edit
      end
    end
  end

  describe "POST search" do
    it "finds the sight" do
      sight1 = Fabricate(
        :sight,
        name: "Statue of Liberty",
        address: "Statue of Liberty, NY, USA"
      )
      post :results, location: "New York, NY, USA"
      expect(Sight.first.name).to eq(sight1.name)
    end
  end
end
