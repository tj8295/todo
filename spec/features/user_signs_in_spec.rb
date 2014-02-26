require 'spec_helper'

feature 'User signs in' do
  background do
    User.create(username: "john", full_name: "John Doe")
  end

  scenario "with existing username" do
    visit root_path
    fill_in "username", with: "john"
    click_button "Sign in"
    page.should have_content "John Doe"
  end
end



