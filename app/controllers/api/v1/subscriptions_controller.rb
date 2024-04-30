class Api::V1::SubscriptionsController < ApplicationController
  def create
    
    customer = find_customer_by_email(params[:customer_email])
    subscription = customer.subscriptions.new(sub_params)
    

    if subscription.save
     render json: SubscriptionSerializer.new(subscription), status: :created
    else
     render json: subscription.errors, status: :unauthorized
    end
  end

  private 

  def sub_params
    params.permit(:title, :price, :frequency, :status)
  end
end