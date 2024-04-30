class Tea < ApplicationRecord
  validates :title, :description, :temperature, :brew_time, presence: :true
  validates :title, uniqueness: { case_sensitive: false }

  has_many :tea_subscriptions
  has_many :subscriptions, through: :tea_subscriptions

  

end
