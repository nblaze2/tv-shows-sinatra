require "spec_helper"

feature "user adds a new TV show" do
  # As a TV fanatic
  # I want to add one of my favorite shows
  # So that I can encourage others to binge watch it
  #
  # Acceptance Criteria:
  scenario "successfully add a new show" do
    # * I must provide the title, network, and starting year.

    visit "/television_shows"
    click_link('Add New Show')

    fill_in('television_show[title]', with: 'Life in Pieces')
    fill_in('television_show[network]', with: 'CBS')
    fill_in('television_show[starting_year]', with: 2015)
    select('Comedy', from: 'television_show[genre]')
    click_button('Add TV Show')

    # * I can optionally provide the final year, genre, and synopsis.
    # * The synopsis can be no longer than 5000 characters.

    click_link('Add New Show')

    fill_in('television_show[title]', with: 'The West Wing')
    fill_in('television_show[network]', with: 'NBC')
    fill_in('television_show[starting_year]', with: 1999)
    fill_in('television_show[ending_year]', with: 2006)
    select('Drama', from: 'television_show[genre]')
    fill_in('television_show[synopsis]', with: "The West Wing is an American serial political drama television series created by Aaron Sorkin that was originally broadcast on NBC from September 22, 1999, to May 14, 2006. The series is set primarily in the West Wing of the White House, where the Oval Office and offices of presidential senior staff are located, during the fictitious Democratic administration of Josiah Bartlet (played by Martin Sheen).

    The West Wing received acclaim from critics, as well as praise from political science professors and former White House staffers. In total, The West Wing won three Golden Globe Awards and 26 Emmy Awards, including the award for Outstanding Drama Series, which it won four consecutive times from 2000 through 2003. The Writers Guild of America also ranked it #10 in its '101 Best-Written TV Series' list.")
    click_button('Add TV Show')

    # And should see both TV shows listed (just the title and network)
    expect(page).to have_content("Life in Pieces (CBS)")
    expect(page).to have_content("The West Wing (NBC)")

    # * The starting year and ending year (if provided) must be
    #   greater than 1900.
    # * The genre must be one of the following: Action, Mystery,
    #   Drama, Comedy, Fantasy
    # * If any of the above validations fail, the form should be
    #   re-displayed with the failing validation message.



  end
  scenario "fail to add a show with invalid information" do
    visit "/television_shows"
    click_link('Add New Show')

    fill_in('television_show[network]', with: 'Fox')
    fill_in('television_show[starting_year]', with: '1776')
    select('Comedy', from: 'television_show[genre]')
    click_button('Add TV Show')

    expect(page).to have_content("Error(s)")
  end
end
