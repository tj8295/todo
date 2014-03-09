class PaymentsController < ApplicationController

  def create

    Stripe.api_key = "sk_test_S7SfOyW1ciRq6DBVsEb7WPRW"

    # Get the credit card details submitted by the form
    token = params[:stripeToken]

    # Create the charge on Stripe's servers - this will charge the user's card
    begin
      charge = Stripe::Charge.create(
        :amount => 1000, # amount in cents, again
        :currency => "usd",
        :card => token,
        :description => "payinguser@example.com"
      )

      flash[:success] = "Thank you for your generous support!"
      redirect_to new_payment_path

    rescue Stripe::CardError => e
      flash[:danger] = e.message
      redirect_to new_payment_path
    end
  end
end
