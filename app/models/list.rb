class List < ApplicationRecord
  extend CommonScopes

  has_many :subscriptions, dependent: :restrict_with_error
  has_many :leads, -> { where(status: SubscriptionStatus::ACTIVE) }, through: :subscriptions

  def to_s
    name
  end
end
