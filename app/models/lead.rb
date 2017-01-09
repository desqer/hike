class Lead < ApplicationRecord
  has_many :subscriptions, dependent: :destroy
  has_many :lists, -> { where(status: SubscriptionStatus::ACTIVE) }, through: :subscriptions
end
