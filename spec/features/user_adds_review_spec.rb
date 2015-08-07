require "spec_helper"

feature "User creates a review", :js do
  scenario "for authenticated user" do
    user1 = Fabricate(:user)
    sight1 = Fabricate(:sight, category: Fabricate(:category))
    sign_in(user1)

    visit sight_path(sight1)
    expect(page).to have_content("Rate this Sight")

    add_a_rating_and_review
    expect(page).to have_content(
      "Your review of #{sight1.name} has been added.")
    expect_review_to_be_visible

    click_link "Edit this review"
    expect(page).to have_content("Update Review")

    sign_out
    visit sight_path(sight1)
    expect_review_to_be_visible
  end

  scenario "for unauthenticated user" do
    sign_out
    sight1 = Fabricate(:sight, category: Fabricate(:category))

    visit sight_path(sight1)
    expect(page).to have_content("Sign in to add your review")
    expect(page).not_to have_content("Rate this Sight")
  end

  private

  def add_a_rating_and_review
    select "3 Stars", from: "Rating"
    fill_in "Write Review", with: "This place is pretty good."
    click_button "Add Review"
  end

  def expect_review_to_be_visible
    expect(page).to have_content("This place is pretty good.")
  end
end
