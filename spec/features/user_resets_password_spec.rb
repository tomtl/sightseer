require "spec_helper"

feature "User resets password" do
  scenario "user successfully resets password" do
    user1 = Fabricate(:user, password: "old_password")

    visit sign_in_path
    click_link "Forgot password?"
    fill_in "Email address", with: user1.email
    click_button "Send Email"
    expect(page).to have_content("We have sent an email with instructions")

    open_email(user1.email)
    current_email.click_link "Reset my password"

    fill_in "New Password", with: "new_password"
    click_button "Reset Password"
    expect(page).to have_content("Your password has been updated")

    fill_in "Email Address", with: user1.email
    fill_in "Password", with: "new_password"
    click_button "Sign In"
    expect(page).to have_content("Welcome #{user1.full_name}")

    clear_email
  end
end