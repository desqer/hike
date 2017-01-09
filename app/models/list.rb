class List < ApplicationRecord
  has_many :subscriptions, dependent: :restrict_with_error
  has_many :leads, -> { where(status: SubscriptionStatus::ACTIVE) }, through: :subscriptions
end
