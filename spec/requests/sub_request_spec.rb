require 'rails_helper'

RSpec.describe 'Subscription create' do
  describe 'subscription create' do
    before(:each) do
      @customer1 = Customer.create!( first_name: "General", last_name: "Iroh", email: "dragonofthewest@gmail.com", address: "123 Pi Cho Ct, Ba Sing Se")
      @tea1 = Tea.create!(title: "Ginseng",description: "Ginseng has been used for improving overall health. It has also been used to strengthen the immune system and help fight off stress and disease.",temperature: "208°F",brew_time: "5 - 10 minutes")
    end

    describe 'happy path' do
      it 'creates a subscriptionfor a customer and tea' do
        params = {
          customer_email: "#{@customer1.email}",
          title: "#{@tea1.title}",
          price: 9.00,
          frequency: "1 week"
        }

        headers = {
          "Content-Type": "application/json",
          "Accept": "application/json"
        }

        post api_v1_customer_subscriptions_path(@customer1), headers: headers, params: JSON.generate(params)

        result = JSON.parse(response.body, symbolize_names: true)
        # require 'pry'; binding.pry
      end
    end
  end
end
