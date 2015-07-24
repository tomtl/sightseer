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

      it "adds the user to the session" do
        expect(session[:user_id]).to eq(User.first.id)
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
        expect(flash[:danger]).to be_present
      end

      it "sets @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end

      it "renders the :new template" do
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET edit" do
    it "sets @user" do
      user1 = Fabricate(:user)
      get :edit, id: user1.id
      expect(assigns(:user)).to eq(user1)
    end
  end

  describe "POST update" do
    context "with valid input" do
      let(:user1) { Fabricate(:user, email: "robert@original_email.com") }
      before { post :update, id: user1.id, user: { email: "bob@example.com" } }

      it "updates the user" do
        expect(User.first.email).to eq("bob@example.com")
      end

      it "sets the success message" do
        expect(flash[:success]).to be_present
      end

      it "redirects to the home path" do
        expect(response).to redirect_to home_path
      end
    end

    context "with invalid inputs" do
      let(:user1) { Fabricate(:user, email: "robert@original_email.com") }
      before { post :update, id: user1.id, user: { email: "" } }

      it "does not update the user" do
        expect(User.first.email).to eq("robert@original_email.com")
      end

      it "sets the error message" do
        expect(flash[:danger]).to be_present
      end

      it "sets @user" do
        expect(assigns(:user)).to eq(user1)
      end

      it "renders the :edit template" do
        expect(response).to render_template :edit
      end
    end
  end
end
