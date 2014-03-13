require 'spec_helper'

feature "visitor makes payment", js: true do

background do
  visit new_payment_path
end

# you can use webkit as the default javascript runner and run individual tests on selinium to visually see what is going on.

  scenario "valid card number", driver: selenium do
    pay_with_credit_card('4242 4242 4242 4242')
    page.should have_content "Thank you for your support."
  end

  scenario "invalid card number" do
    pay_with_credit_card('4000000000000069')
    page.should have_content "Your expiration date is incorrect."
  end

  scenario "declined card number" do
    pay_with_credit_card('4000000000000002')
    page.should have_content("Your card was declined.")
  end
end

def pay_with_credit_card(card_number)
    fill_in "credit Card Number", with: card_number
    fill_in "Security Code", with: "235"
    select "3 - March", from: "date_month"
    select "2015", from: "date_year"
end
