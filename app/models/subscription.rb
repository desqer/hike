class Subscription < ApplicationRecord
  extend CommonScopes

  has_enumeration_for :status, with: SubscriptionStatus, create_helpers: true, create_scopes: true

  belongs_to :lead
  belongs_to :list

  delegate :name, :email, to: :lead, prefix: true
  delegate :name, to: :list, prefix: true

  def activate!
    active! and save!
  end

  def deactivate!
    canceled! and save!
  end

  def to_s
    "#{lead_name} on #{list_name}"
  end
end
