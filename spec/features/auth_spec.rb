require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New User"
  end

  feature "signing up a user" do
    before(:each) do
      visit new_user_url
      fill_in 'Email', :with => "testing@email.com"
      fill_in 'Password', :with => "biscuits"
      click_on "Create User"
    end

    scenario "redirects to bands index page after signup" do
      expect(page).to have_content 'All the bands'
    end
  end

  feature "with an invalid user" do
    before(:each) do
      visit new_user_url
      fill_in 'Email', :with => "testing@email.com"
      click_on "Create User"
    end

    scenario "re-renders the signup page after failed signup" do
      expect(page).to have_content 'Password is too short'
    end
  end

end