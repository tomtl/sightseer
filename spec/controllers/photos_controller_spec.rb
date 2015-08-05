require "spec_helper"

describe PhotosController do
  describe "GET new" do
    it "sets @sight" do
      set_current_user
      get :new, sight_id: Fabricate(:sight)
      expect(assigns(:sight)).to be_instance_of(Sight)
    end

    it "sets @photo" do
      set_current_user
      get :new, sight_id: Fabricate(:sight)
      expect(assigns(:photo)).to be_instance_of(Photo)
    end

    it_behaves_like "requires sign in" do
      let(:action) { get :new, sight_id: 1 }
    end
  end

  describe "POST create" do
    context "for valid inputs" do
      before do
        set_current_user
        photo_params = {
          description: "Photo of a place",
          image: fixture_file_upload("files/example.jpg")
        }
        post :create, sight_id: Fabricate(:sight), photo: photo_params
      end

      it "saves the photo" do
        expect(Photo.count).to eq(1)
      end

      it "associates the photo with the correct user" do
        expect(Photo.first.user).to eq(current_user)
      end

      it "associates the photo with the correct sight" do
        expect(Photo.first.sight).to eq(Sight.first)
      end

      it "sets the success message" do
        expect(flash[:success]).to be_present
      end

      it "renders the new template" do
        expect(response).to redirect_to sight_path(Sight.first)
      end
    end

    context "for invalid inputs" do
      before do
        set_current_user
        photo_params = { description: "Photo of a place", image: "" }
        post :create, sight_id: Fabricate(:sight), photo: photo_params
      end

      it "does not create the photo" do
        expect(Photo.count).to eq(0)
      end

      it "sets the error message" do
        expect(flash[:danger]).to be_present
      end

      it "renders the new template" do
        expect(response).to render_template :new
      end
    end

    context "for unauthenticated users" do
      it_behaves_like "requires sign in" do
        let(:action) { post :create, sight_id: 1 }
      end
    end
  end

  describe "GET show" do
    it "sets @photo" do
      user1 = Fabricate(:user)
      set_current_user(user1)
      sight1 = Fabricate(:sight)
      photo1 = Photo.new(
        description: "Here is description",
        sight_id: sight1.id,
        user_id: user1.id,
      )
      photo1.save(validate: false)
      get :show, sight_id: sight1.id, id: photo1.id
      expect(assigns(:photo)).to be_present
    end
  end

  describe "GET edit" do
    it "sets @photo" do
      set_current_user
      sight1 = Fabricate(:sight)
      photo1 = Photo.new(
        description: "Here is description",
        sight_id: sight1.id,
        user_id: 1,
      )
      photo1.save(validate: false)
      get :edit, sight_id: sight1, id: photo1
      expect(assigns(:photo)).to eq(photo1)
    end

    it_behaves_like "requires sign in" do
      let(:action) { get :edit, sight_id: 1, id: 1 }
    end
  end

  describe "POST update" do
    context "for valid inputs" do
      let(:sight1) { Fabricate(:sight) }

      before do
        user1 = Fabricate(:user)
        set_current_user(user1)
        photo1 = Photo.new(
          description: "Original description",
          sight_id: sight1.id,
          user_id: user1.id,
        )
        photo1.save(validate: false)

        post :update,
          sight_id: sight1,
          id: photo1,
          photo: { description: "Updated description" }
      end

      it "updates the photo" do
        expect(Photo.first.description).to eq("Updated description")
      end

      it "sets the success message" do
        expect(flash[:success]).to be_present
      end

      it "redirects to the photo page" do
        expect(response).to redirect_to sight_photo_path(sight1, Photo.first)
      end
    end

    context "for a user that did not create the photo" do
      let(:sight1) { Fabricate(:sight) }

      before do
        photo_creator = Fabricate(:user)
        another_user = Fabricate(:user)
        set_current_user(another_user)
        photo1 = Photo.new(
          description: "Original description",
          sight_id: sight1.id,
          user_id: photo_creator.id,
        )
        photo1.save(validate: false)

        post :update,
          sight_id: sight1,
          id: photo1,
          photo: { description: "Updated description" }
      end

      it "does not update the photo" do
        expect(Photo.first.description).to eq("Original description")
      end

      it "sets the error message" do
        expect(flash[:danger]).to be_present
      end
      it "redirects_to the sight page" do
        expect(response).to redirect_to sight_path(sight1)
      end
    end

    it_behaves_like "requires sign in" do
      let(:action) do
        post :update,
          sight_id: 1,
          id: 1,
          photo: { description: "Updated description" }
      end
    end
  end
end
