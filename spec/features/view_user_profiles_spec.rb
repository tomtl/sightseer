require "spec_helper"

feature "View user profiles" do
  scenario "User views their own profile" do
    user1 = Fabricate(:user)
    sign_in(user1)
    sight1 = Fabricate(:sight)
    Fabricate(:review, sight: sight1, user_id: user1.id)
    Fabricate(:visited_sight, sight_id: sight1.id, user_id: user1.id)

    click_link "My Profile"
    expect(page).to have_content(user1.full_name)
    expect(page).to have_content("Reviews (1)")
    expect(page).to have_content("Visited Sights (1)")
    click_link "Visited Sights (1)"
    expect(page).to have_content("Photos (0)")
    click_link "Photos (0)"
  end
end
