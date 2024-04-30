require 'rails_helper'

RSpec.describe Subscription, type: :model do
 
  describe 'validations' do
    
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:frequency) }
    it { should validate_presence_of(:status) }

    it { should belong_to(:customer) }
    it { should have_many(:tea_subscriptions) }
  end
end
    
