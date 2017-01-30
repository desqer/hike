class Lead < ApplicationRecord
  extend CommonScopes

  has_many :subscriptions, dependent: :destroy
  has_many :lists, -> { merge(Subscription.active) }, through: :subscriptions

  alias_attribute :display_name, :to_s

  def to_s
    email
  end
end
