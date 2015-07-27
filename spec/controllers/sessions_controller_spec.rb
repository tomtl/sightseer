require "spec_helper"

describe SessionsController do
  describe "GET new" do
    it "renders the new template for unauthenticated users" do
      get :new
      expect(response).to render_template :new
    end

    it "redirects to the home page for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end
  end

  describe "POST create" do
    context "with valid credentials" do
      it "puts the user in the session" do
        user1 = Fabricate(:user)
        post :create, email: user1.email, password: user1.password
        expect(session[:user_id]).to eq(user1.id)
      end

      it "sets the success notice" do
        user1 = Fabricate(:user)
        post :create, email: user1.email, password: user1.password
        expect(flash[:success]).to be_present
      end

      it "redirects to the home page" do
        user1 = Fabricate(:user)
        post :create, email: user1.email, password: user1.password
        expect(response).to redirect_to home_path
      end
    end

    context "with invalid credentials" do
      it "does not put the user in the session" do
        user1 = Fabricate(:user, password: "password")
        post :create, email: user1.email, password: "abcdefg"
        expect(session[:user_id]).to be_nil
      end

      it "sets the error notice" do
        user1 = Fabricate(:user, password: "password")
        post :create, email: user1.email, password: "abcdefg"
        expect(flash[:danger]).to be_present
      end

      it "redirects to the sign in page" do
        user1 = Fabricate(:user, password: "password")
        post :create, email: user1.email, password: "abcdefg"
        expect(response).to redirect_to sign_in_path
      end
    end
  end

  describe "DELETE destroy" do
    before do
      set_current_user
      delete :destroy
    end

    it "removes the user from the session" do
      expect(session[:user_id]).to be_nil
    end

    it "sets the success message" do
      expect(flash[:success]).to be_present
    end

    it "redirects to the root path" do
      expect(response).to redirect_to root_path
    end
  end
end
