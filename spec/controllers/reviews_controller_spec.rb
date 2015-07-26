require "spec_helper"

describe ReviewsController do
  describe "POST create" do
    context "with authenticated user" do
      before { set_current_user }

      context "with valid inputs" do
        let(:sight1) { Fabricate(:sight) }
        let(:review1) { Fabricate.attributes_for(:review, sight_id: sight1.id) }
        before { post :create, review: review1, sight_id: sight1.id }

        it "creates the review" do
          expect(Review.first.content).to eq(review1[:content])
        end

        it "assigns the review to the correct sight" do
          expect(Review.first.sight).to eq(sight1)
        end

        it "assigns the review to the current user" do
          current_user = User.find(session[:user_id])
          expect(Review.first.creator).to eq(current_user)
        end
        it "sets the success message" do
          expect(flash[:success]).to be_present
        end

        it "redirects to the sight show path" do
          expect(response).to redirect_to sight_path(sight1)
        end
      end

      context "with invalid inputs" do
        let(:sight1) { Fabricate(:sight) }

        let(:review1) do
          Fabricate.attributes_for(:review, sight_id: sight1.id, rating: nil)
        end

        before { post :create, review: review1, sight_id: sight1.id }

        it "does not create the review" do
          expect(Review.count).to eq(0)
        end

        it "sets the error message" do
          expect(flash[:danger]).to be_present
        end

        it "renders the sight/show template" do
          expect(response).to render_template("sights/show")
        end

        it "sets @sight" do
          expect(assigns(:sight)).to eq(sight1)
        end

        it "sets @reviews" do
          existing_review = Fabricate(:review, sight_id: sight1.id)
          post :create, review: review1, sight_id: sight1.id
          expect(assigns(:reviews)).to match_array([existing_review])
        end
      end
    end

    context "with unauthenticted users" do
      it_behaves_like "requires sign in" do
        let(:action) { post :create, review_id: 1, sight_id: 1 }
      end
    end
  end

  describe "GET edit" do
    it "sets @review" do
      user1 = Fabricate(:user)
      set_current_user(user1)
      sight1 = Fabricate(:sight)
      review1 = Fabricate(:review, sight: sight1, user_id: user1.id)
      get :edit, sight_id: sight1.id, id: review1.id
      expect(assigns(:review)).to eq(review1)
    end

    it_behaves_like "requires sign in" do
      let(:action) { get :edit, sight_id: 1, id: 1 }
    end

    it "redirects to sight show page if user is not the review creator" do
      review1 = Fabricate(:review)
      user2 = Fabricate(:user)
      set_current_user(user2)
      get :edit, sight_id: review1.sight.id, id: review1.id
      expect(response).to redirect_to sight_path(review1.sight)
    end
  end

  describe "PATCH update" do
    context "with valid inputs" do
      let(:current_user) { Fabricate(:user) }
      let(:review1) { Fabricate(:review, user_id: current_user.id) }

      before do
        set_current_user(current_user)
        patch :update,
              sight_id: review1.sight.id,
              id: review1.id,
              review: { content: "Here's an update." }
      end

      it "updates the review" do
        expect(Review.first.content).to eq("Here's an update.")
      end

      it "sets the success message" do
        expect(flash[:success]).to be_present
      end

      it "redirects to the sight page" do
        expect(response).to redirect_to sight_path(review1.sight)
      end
    end

    context "with invalid inputs" do
      let(:current_user) { Fabricate(:user) }
      let(:review1) { Fabricate(:review, user_id: current_user.id) }

      before do
        set_current_user(current_user)
        patch :update,
              sight_id: review1.sight.id,
              id: review1.id,
              review: { rating: nil }
      end

      it "does not update the review" do
        expect(Review.first.rating).to eq(review1.rating)
      end

      it "sets the error message" do
        expect(flash[:danger]).to be_present
      end

      it "renders the :edit view template" do
        expect(response).to render_template :edit
      end
    end

    context "for unauthenticated user" do
      it_behaves_like "requires sign in" do
        let(:action) { patch :update, sight_id: 1, id: 1 }
      end
    end

    context "with incorrect user" do
      let(:review_creator) { Fabricate(:user) }
      let(:review1) { Fabricate(:review, user_id: review_creator.id) }
      let(:another_user) { Fabricate(:user) }

      before do
        set_current_user(another_user)
        patch :update,
              sight_id: review1.sight.id,
              id: review1.id,
              review: { content: "Here's an update." }
      end

      it "does not update the review" do
        expect(Review.first.content).to eq(review1.content)
      end

      it "sets the error messsage" do
        expect(flash[:danger]).to be_present
      end

      it "redirects to the sight page" do
        expect(response).to redirect_to sight_path(review1.sight)
      end
    end
  end
end
