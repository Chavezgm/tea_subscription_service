class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response 

  def not_found_response
    render json: { error: 'Sorry, your credentials are bad!' }, status: :unauthorized
  end

  def find_customer_by_email(email)
    if customer = Customer.find_by(email: email)
      customer
    else
      raise ActiveRecord::RecordNotFound
    end
  end
end
