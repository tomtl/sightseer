require "spec_helper"

feature "User adds a photo" do
  scenario "for authenticated user" do
    user1 = Fabricate(:user)
    sight1 = Fabricate(:sight, category: Fabricate(:category))
    sign_in(user1)
    image_file = "spec/fixtures/files/example.jpg"

    visit sight_path(sight1)
    click_link "Add Photos"
    expect(page).to have_content("Upload photo for")

    fill_in "Description", with: "Photo I took of the sight"
    attach_file("Image", image_file)
    click_button "Add Photo"
    expect(page).to have_content("has been added successfully")

    sign_out
    visit sight_photo_path(sight1, Photo.first)
    expect(page).to have_content("Photo I took of the sight")
  end
end