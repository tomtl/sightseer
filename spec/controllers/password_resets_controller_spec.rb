require "spec_helper"

describe PasswordResetsController do
  describe "GET show" do
    it "sets @token" do
      user1 = Fabricate(:user)
      user1.update_column(:token, "12345")
      get :show, id: "12345"
      expect(assigns(:token)).to eq(user1.token)
    end

    it "renders the show template if the token is valid" do
      user1 = Fabricate(:user)
      user1.update_column(:token, "12345")
      get :show, id: "12345"
      expect(response).to render_template :show
    end

    it "redirects to the expired token page if token is not valid" do
      get :show, id: "12345"
      expect(response).to redirect_to expired_token_path
    end
  end

  describe "POST create" do
    context "with valid token" do
      before do
        user1 = Fabricate(:user)
        user1.update_column(:token, "12345")
        post :create, password: "new_password", token: "12345"
      end

      it "updates the user's password" do
        expect(User.first.authenticate("new_password")).to be_truthy
      end

      it "sets the success message" do
        expect(flash[:success]).to be_present
      end

      it "deletes the user's token" do
        expect(User.first.token).to be_nil
      end

      it "redirects to the sign in page" do
        expect(response).to redirect_to sign_in_path
      end
    end

    context "with invalid token" do
      before do
        Fabricate(:user)
        post :create, password: "new_password", token: "12345"
      end

      it "does not update the password" do
        expect(User.first.authenticate("new_password")).to eq false
      end

      it "redirects to the expired token path" do
        expect(response).to redirect_to expired_token_path
      end
    end

    context "with invalid inputs" do
      it "does not update the password if it is blank" do
        user1 = Fabricate(:user, password: "old_password")
        user1.update_column(:token, "12345")
        post :create, password: "", token: "12345"
        expect(User.first.authenticate("")).to eq false
      end
    end
  end
end
