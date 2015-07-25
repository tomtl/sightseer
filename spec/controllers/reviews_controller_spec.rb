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
          current_user  = User.find(session[:user_id])
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
        let(:review1) { Fabricate.attributes_for(:review, sight_id: sight1.id, rating: nil) }
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
end
