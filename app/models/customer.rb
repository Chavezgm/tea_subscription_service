class Customer < ApplicationRecord
  validates :first_name, :last_name, :email, :address, presence: :true
  validates :email, uniqueness: { case_sensitive: false }
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}

  has_many :subscriptions
end
