require "spec_helper"

describe VisitedSightsController do
  describe "POST create" do
    context "for valid inputs" do
      let(:sight1) { Fabricate(:sight) }

      before do
        set_current_user
        post :create, sight_id: sight1.id, user_id: current_user.id
      end

      it "creates the visited sight" do
        expect(VisitedSight.count).to eq(1)
      end

      it "associates the visited sight with the current user" do
        expect(VisitedSight.first.user).to eq(current_user)
      end

      it "associates the visited sight with the correct sight" do
        expect(VisitedSight.first.sight).to eq(sight1)
      end

      it "sets the flash success message" do
        expect(flash[:success]).to be_present
      end

      it "renders the sights/show page" do
        expect(response).to render_template "sights/show"
      end
    end

    context "for invalid inputs" do
      before do
        set_current_user
        sight1 = Fabricate(:sight)
        Fabricate(:visited_sight, user_id: current_user.id, sight_id: sight1.id)
        post :create, sight_id: sight1.id, user_id: current_user.id
      end

      it "does not create duplicate records" do
        expect(VisitedSight.count).to eq(1)
      end

      it "displays the error message" do
        expect(flash[:danger]).to be_present
      end

      it "renders the sights/show page" do
        expect(response).to render_template "sights/show"
      end
    end

    context "for unauthenticated users" do
      it_behaves_like "requires sign in" do
        let(:action) { post :create, sight_id: 1, user_id: 1 }
      end
    end
  end

  describe "GET index" do
    it "sets @user" do
      set_current_user
      user2 = Fabricate(:user)
      Fabricate(:visited_sight, user_id: user2.id)
      get :index, user_id: user2.id
      expect(assigns(:user)).to eq(user2)
    end

    it "sets @visited_sights" do
      set_current_user
      user2 = Fabricate(:user)
      visited_sight1 = Fabricate(:visited_sight, user_id: user2.id)
      get :index, user_id: user2.id
      expect(assigns(:visited_sights)).to eq([visited_sight1])
    end

    it_behaves_like "requires sign in" do
      let(:action) { get :index, user_id: 1 }
    end
  end

  describe "DELETE destroy" do
    context "for valid inputs" do
      before do
        set_current_user
        visited_sight1 = Fabricate(:visited_sight, user_id: current_user.id)
        delete :destroy, user_id: current_user.id, id: visited_sight1.id
      end

      it "deletes the visited_sight record" do
        expect(VisitedSight.count).to eq(0)
      end

      it "sets success message" do
        expect(flash[:success]).to be_present
      end

      it "renders the index template" do
        expect(response).to redirect_to user_visited_sights_path(
          user_id: current_user.id)
      end
    end

    context "for incorrect user" do
      before do
        set_current_user
        user2 = Fabricate(:user)
        visited_sight1 = Fabricate(:visited_sight, user_id: user2.id)
        delete :destroy, user_id: user2.id, id: visited_sight1.id
      end

      it "does not delete the visited_sight record" do
        expect(VisitedSight.count).to eq(1)
      end

      it "sets the flash error message" do
        expect(flash[:danger]).to be_present
      end

      it "redirects to the current users home page" do
        expect(response).to redirect_to home_path
      end
    end

    it_behaves_like "requires sign in" do
      let(:action) { delete :destroy, user_id: 1, id: 1 }
    end
  end
end
