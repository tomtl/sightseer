require "spec_helper"

describe VisitedSightsController do
  describe "POST create" do
    context "for valid inputs" do
      let(:sight1) { Fabricate(:sight) }

      before  do
        set_current_user
        post :create, sight_id: sight1.id
      end

      it "creates the visited sight" do
        expect(VisitedSight.count).to eq(1)
      end

      it "associates the visited sight with the correct user" do
        expect(VisitedSight.first.user).to eq(current_user)
      end

      it "associates the visited wight with the correct sight" do
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
      it "does not create the visited sight" do
        post :create, sight_id: nil
        expect(VisitedSight.count).to eq(0)
      end

      it "does not create duplicate records" do
        set_current_user
        sight1 = Fabricate(:sight)
        visited_sight1 = Fabricate(:visited_sight, user_id: current_user.id, sight_id: sight1.id)
        post :create, sight_id: sight1.id
        expect(VisitedSight.count).to eq(1)
      end

      it "displays the error message" do
        set_current_user
        sight1 = Fabricate(:sight)
        visited_sight1 = Fabricate(:visited_sight, user_id: current_user.id, sight_id: sight1.id)
        post :create, sight_id: sight1.id
        expect(flash[:danger]).to be_present
      end

      it "renders the sights/show page" do
        set_current_user
        sight1 = Fabricate(:sight)
        visited_sight1 = Fabricate(:visited_sight, user_id: current_user.id, sight_id: sight1.id)
        post :create, sight_id: sight1.id
        expect(response).to render_template "sights/show"
      end
    end

    context "for unauthenticated users" do
      it_behaves_like "requires sign in" do
        let(:action) { post :create, sight_id: 1 }
      end
    end
  end
end
