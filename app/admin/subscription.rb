ActiveAdmin.register Subscription do
  menu priority: 2

  scope :all, default: true
  scope :active
  scope :pending
  scope :canceled

  filter :list
  filter :created_at

  index do
    column(:status) { |subscription| status_tag subscription.status }
    column(:list)
    column(:lead)
    column(:created_at)

    actions
  end

  form do |f|
    f.inputs do
      f.input :lead
      f.input :list
      f.input :status, as: :select, collection: SubscriptionStatus.to_a
    end

    f.actions
  end
end
