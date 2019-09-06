require "rails_helper"
# As a user
# When I visit "/"
# And I select "Greyjoy" from the dropdown
# And I click on "Get Members"
# Then my path should be "/search" with "house=greyjoy" in the parameters
# And I should see a message "7 Members"
# And I should see a list of the 7 members of House Greyjoy
# And I should see a name and id for each member.
# Your key is: egg

RSpec.describe "As a user", type: :feature do
  describe "Index Page - Westeros House Members" do
    it "I should see a list of the 7 members of House Greyjoy" do
      visit "/"
      # save_and_open_page

      page.select "Greyjoy", from: "house"
      click_on "Get Members"

      expect(current_path).to eq("/search")
      expect(page).to have_content("7 Members")
      expect(page).to have_css(".house-members-list", count: 7)

      within(first(".house-members-list")) do
        expect(page).to have_content("Id")
        expect(page).to have_content("Name")
      end
    end
  end
end
