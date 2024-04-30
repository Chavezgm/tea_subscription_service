require 'rails_helper'

RSpec.describe Tea, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:temperature) }
    it { should validate_presence_of(:brew_time) }

    it { should have_many(:tea_subscriptions) }
  end
end
