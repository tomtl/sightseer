require "spec_helper"

feature "User signs in" do
  scenario "user signing in" do
    user1 = Fabricate(:user)
    visit root_path
    click_link "Sign In"
    fill_in "Email Address", with: user1.email
    fill_in "Password", with: user1.password
    click_button "Sign In"
    expect(page).to have_content(
      "Welcome #{user1.full_name}! You are signed in.")

    click_link "Sign Out"
    expect(page).to have_content("You are now signed out.")
  end
end
