require "spec_helper"

describe UsersController do
  describe "GET new" do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create" do
    context "successful user signup" do
      before { post :create, user: Fabricate.attributes_for(:user) }

      it "creates the user" do
        expect(User.count).to eq(1)
      end

      it "sets the success message" do
        expect(flash[:success]).to be_present
      end

      it "redirects to the home page" do
        expect(response).to redirect_to home_path
      end
    end

    context "failed user signup" do
      before { post :create, user: { name: "Billy Bob" } }
      it "does not create the user" do
        expect(User.count).to eq(0)
      end

      it "sets the error message" do
        expect(flash[:error]).to be_present
      end

      it "sets @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end

      it "renders the :new template" do
        expect(response).to render_template(:new)
      end
    end
  end
end