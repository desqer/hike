class Subscription < ApplicationRecord
  extend CommonScopes

  has_enumeration_for :status, with: SubscriptionStatus

  belongs_to :lead
  belongs_to :list
end
