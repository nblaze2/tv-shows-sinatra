require "spec_helper"

feature "user edits existing show" do

# As a TV fanatic
# I want to edit an existing show
# So that I can correct any foolish mistakes

# Acceptance Criteria:
# * Editing a show provides a pre-populated form for each field.
# * Submitting the edit form will update a show if all validations pass.
# * The user is redirected to the details page for that show if successfully updated.
# * If the update fails any validations, re-display the form with the appropriate error messages.
  scenario "successfully edit existing show" do
    jeopardy = TelevisionShow.create!({
        title: "Jeapordy", network: "Columbia broadcast system",
        starting_year: 1984, genre: "Mystery" # show wasn't real till Alex let's be honest
    })

    visit "/television_shows"

    expect(page).to have_content("Jeapordy (Columbia broadcast system)")

    click_link('Edit')

    fill_in('Network', with: 'CBS')
    fill_in('Starting Year', with: '1964')
    fill_in('Title', with: 'Jeopardy')
    click_button('Update TV Show')

    expect(page).to have_content("Jeopardy (CBS)")
  end
end
