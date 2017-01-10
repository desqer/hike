class Lead < ApplicationRecord
  extend CommonScopes

  has_many :subscriptions, dependent: :destroy
  has_many :lists, -> { merge(Subscription.active) }, through: :subscriptions

  def to_s
    email
  end
end
