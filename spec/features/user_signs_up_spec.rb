require "spec_helper"

feature "Signing up", :js do
  scenario "Sign up" do
    visit root_path
    click_link "Sign Up"

    user1 = Fabricate.attributes_for(:user)
    fill_in "Email Address", with: user1[:email]
    fill_in "Full Name", with: user1[:full_name]
    fill_in "Password", with: user1[:password]
    click_button "Sign Up"
    expect(page).to have_content "Welcome #{user1[:full_name]}!"
  end
end
