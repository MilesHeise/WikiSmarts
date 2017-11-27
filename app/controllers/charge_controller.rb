class ChargeController < ApplicationController
  after_save { current_user.role ||= :premium }

  def new
    @stripe_btn_data = {
      key: Rails.configuration.stripe[:publishable_key].to_s,
      description: "Membership - #{current_user.name}",
      # does my current_user even have a name property at the moment?
      amount: Amount.default
    }
  end

  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: Amount.default,
      description: "Membership - #{current_user.email}",
      currency: 'usd'
    )

    flash[:notice] = "Thanks for upgrading, #{current_user.email}! Ready to start your first private wiki?"
    redirect_to wikis_path # set this to new premium wiki create page?
   rescue Stripe::CardError => e
     flash[:alert] = e.message
     redirect_to new_charge_path
   end

  private

  class Amount
    def default
      15_00
    end
  end
end
