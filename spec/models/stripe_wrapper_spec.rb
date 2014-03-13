require 'spec_helper'

describe StripeWrapper::Charge do
  before do
    StripeWrapper.set_api_key
  end

  let(:token) do
    Stripe::Token.create(
        :card => {
          :number => card_number,
          :exp_month => 3,
          :exp_year => 2015,
          :cvc => "314"
        }
      ).id
  end

  context "with valid card" do
    let(:card_number) { '4242 4242 4242 4242' }
    it "charges the card successfully", :vcr do
      response = StripeWrapper::Charge.create(amount: 900, card: token)
      response.should be_successful
    end
  end

  context "with invalid card", :vcr do
    let(:card_number) { '4000000000000002'}
    let(:response) { StripeWrapper::Charge.create(amount: 900, card: token) }

    it "does not charege the card" do
      response.should_not be_successful
    end

    it "contains an error message", :vcr do
      response.error_message.should == 'Your card was declined.'
    end
  end
end

