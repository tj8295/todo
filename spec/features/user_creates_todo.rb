require "spec_helper"


feature 'User creates todo' do

  scenario "with existing username" do
    john = User.create(username: "john", full_name: "John Doe")
    user_signs_in(john)
    visit todos_path
    fill_in "Name", with: "paint the fence"
    click_button "Add Todo"
    expect(page).to have_content "paint the fence"
  end
end
