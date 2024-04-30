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
          status: 1 ,
          frequency: "1 week",
        }
        headers = {
          "Content-Type": "application/json",
          "Accept": "application/json"
        }

        post api_v1_customer_subscriptions_path(@customer1), headers: headers, params: JSON.generate(params)

        result = JSON.parse(response.body, symbolize_names: true)
        
        expect(response.status).to eq(201)
        expect(response).to be_successful

        expect(result).to have_key(:data)

        expect(result[:data]).to have_key(:id)
        expect(result[:data]).to have_key(:type)
        expect(result[:data]).to have_key(:attributes)

        expect(result[:data][:id]).to be_a(String)
        expect(result[:data][:type]).to be_a(String)

        expect(result[:data][:attributes]).to have_key(:title)
        expect(result[:data][:attributes]).to have_key(:price)
        expect(result[:data][:attributes]).to have_key(:frequency)
        expect(result[:data][:attributes]).to have_key(:status)


        expect(result[:data][:attributes][:title]).to be_a(String)
        expect(result[:data][:attributes][:price]).to be_a(String)
        expect(result[:data][:attributes][:frequency]).to be_a(String)
        expect(result[:data][:attributes][:status]).to be_a(String)
      end
    end

    describe 'Sad Path' do
      it 'errors when params are not met' do
        params = {
          customer_email: "#{@customer1.email}",
          price: 9.00,
          status: 1 ,
        }

        headers = {
          "Content-Type": "application/json",
          "Accept": "application/json"
        }
        post api_v1_customer_subscriptions_path(@customer1), headers: headers, params: JSON.generate(params)

        post api_v1_customer_subscriptions_path(@customer1), headers: headers, params: JSON.generate(params)

        result = JSON.parse(response.body, symbolize_names: true)
        
        # require 'pry'; binding.pry
        expect(response.status).to eq(401)
        expect(response).to_not be_successful

        expect(result).to be_a(Hash)
        expect(result[:title].first).to eq("can't be blank")
        expect(result[:frequency].first).to eq("can't be blank")

      end

      it 'erros when email does not match up a customer' do
        params = {
          customer_email: "wrongemail@gmail.com",
          title: "#{@tea1.title}",
          price: 9.00,
          status: 1 ,
          frequency: "1 week",
        }
        headers = {
          "Content-Type": "application/json",
          "Accept": "application/json"
        }

        post api_v1_customer_subscriptions_path(@customer1), headers: headers, params: JSON.generate(params)

        result = JSON.parse(response.body, symbolize_names: true)
        
        expect(result).to be_a(Hash)        
        expect(result[:error]).to be_a(String)        
        expect(result[:error]).to eq("Sorry, your credentials are bad!")        
      end
    end
  end

  describe 'Subscription Update' do
    before :each do 
      @customer1 = Customer.create!(first_name: "Bob",last_name: "Iroh", email: "dragonofthewest@gmail.com",address: "123 Pi Cho Ct, Ba Sing Se")
      @tea1 = Tea.create!(title: "Ginseng",description: "Ginseng has been used for improving overall health. It has also been used to strengthen the immune system and help fight off stress and disease.",temperature: "208°F",brew_time: "5 - 10 minutes")
      @subscription1 = @customer1.subscriptions.create!(title: "#{@tea1.title}",price: 6.00,frequency: "1 week")
    end

    describe 'happy path' do
      it 'updates a subscription status to cancelled' do
        params = {
          subscription_id: @subscription1.id,
          status: 1
        }

        headers = {
          "Content-Type": "application/json",
          "Accept": "application/json"
        }

        patch api_v1_customer_subscription_path(@customer1, @subscription1), headers: headers, params: JSON.generate(params)

        result = JSON.parse(response.body, symbolize_names: true)
        expect(result).to be_a(Hash)
        
        expect(response.status).to eq(200)
        expect(response).to be_successful

        expect(result[:data][:attributes][:status]).to eq("active")

        #Changed status to active because its defaulted to cancelled

      end
    end

    describe 'Sad path' do
      it 'does not update status when subscription id does not match' do
        params = {
          subscription_id: 56,
          status: 1
        }

        headers = {
          "Content-Type": "application/json",
          "Accept": "application/json"
        }

        patch api_v1_customer_subscription_path(@customer1, @subscription1), headers: headers, params: JSON.generate(params)

        result = JSON.parse(response.body, symbolize_names: true)
        expect(result).to be_a(Hash)
        
        expect(response.status).to eq(401)
        expect(response).to_not be_successful
      
        expect(result).to have_key(:error)
        expect(result[:error]).to eq("Sorry, your credentials are bad!")
      end
    end


  end
end
