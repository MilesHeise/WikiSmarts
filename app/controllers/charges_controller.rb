class ChargesController < ApplicationController
  def new
    @stripe_btn_data = {
      key: Rails.configuration.stripe[:publishable_key].to_s,
      description: "Membership - #{current_user.email}",
      amount: 15_00
    }
  end

  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: 15_00,
      description: "Membership - #{current_user.email}",
      currency: 'usd'
    )

    current_user.role = 'premium'
    current_user.save

    flash[:notice] = "Thanks for upgrading, #{current_user.email}! Ready to start your first private wiki?"
    redirect_to wikis_path # set this to new premium wiki create page?
   rescue Stripe::CardError => e
     flash[:alert] = e.message
     redirect_to new_charges_path
   end

  def destroy
    current_user.set_standard_role
    redirect_to :back
  end
end
