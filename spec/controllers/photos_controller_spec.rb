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
end