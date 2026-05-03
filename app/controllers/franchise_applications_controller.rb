class FranchiseApplicationsController < ApplicationController

  
  def new
    @franchise_application = FranchiseApplication.new
  end

  def create
    @franchise_application = FranchiseApplication.new(franchise_application_params)
    @franchise_application.status = "pending_payment"
    
    if @franchise_application.save
      # Create Stripe PaymentIntent
      stripe_payment_intent = Stripe::PaymentIntent.create(
        amount: FranchiseApplication::FRANCHISE_FEE,
        currency: 'usd',
        metadata: {
          franchise_application_id: @franchise_application.id,
          applicant_email: @franchise_application.email,
          applicant_name: @franchise_application.name
        }
      )
      
      @franchise_application.update(stripe_payment_intent_id: stripe_payment_intent.id)
      
      # Store in session and redirect
      session[:client_secret] = stripe_payment_intent.client_secret
      session[:application_id] = @franchise_application.id
      
      redirect_to franchise_payment_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def payment
    @client_secret = session[:client_secret]
    @franchise_application = FranchiseApplication.find(session[:application_id])
    render :payment
  end

  def success
    @franchise_application = FranchiseApplication.find_by(stripe_payment_intent_id: params[:payment_intent])
    render :success
  end

  def cancel
    render :cancel
  end

  private

  def franchise_application_params
    params.require(:franchise_application).permit(:name, :email, :phone, :address)
  end
end