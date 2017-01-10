class List < ApplicationRecord
  extend CommonScopes

  has_many :subscriptions, dependent: :restrict_with_error
  has_many :leads, -> { merge(Subscription.active) }, through: :subscriptions

  def to_s
    name
  end
end
