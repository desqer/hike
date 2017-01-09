class Lead < ApplicationRecord
  extend CommonScopes

  has_many :subscriptions, dependent: :destroy
  has_many :lists, -> { where(status: SubscriptionStatus::ACTIVE) }, through: :subscriptions

  def to_s
    name
  end
end
