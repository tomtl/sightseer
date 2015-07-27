require "spec_helper"

feature "User adds sight" do
  scenario "for authenticated user" do
    user1 = Fabricate(:user)
    sign_in(user1)
    monuments = Fabricate(:category, name: "Monuments")
    sight1 = Fabricate.attributes_for(:sight)

    click_link "Add a Sight"
    expect(page).to have_content "Create a Sight"

    fill_in "Name", with: sight1[:name]
    fill_in "Address", with: sight1[:address]
    select  "Monuments", from: "Category"
    fill_in "Description", with: sight1[:description]
    click_button "Create Sight"
    expect(page).to have_content("#{sight1[:name]} has been created successfully!")
    expect(page).to have_content("Average Rating")

    click_link "Edit this Sight"
    expect(page).to have_content("Update: #{sight1[:name]}")
  end

  scenario "for unauthenticated user" do
    sign_out

    click_link "Add a Sight"
    expect(page).to have_content "Please sign in first."
    expect(page).to have_content "Sign In"
  end
end
