class PaymentsController < ApplicationController

  def create
    # Get the credit card details submitted by the form
    token = params[:stripeToken]

    # Create the charge on Stripe's servers - this will charge the user's card
    charge = StripeWrapper::Charge.create( :amount => 1000, :card => token)
      # charge = Stripe::Charge.create(
      #   :amount => 1000, # amount in cents, again
      #   :currency => "usd",
      #   :card => token,
      #   :description => "payinguser@example.com"
      # )
    if charge.successful?
      flash[:success] = "Thank you for your generous support!"
      redirect_to new_payment_path
    else
      flash[:danger] = charge.error_message
      redirect_to new_payment_path
    end
  end
end

