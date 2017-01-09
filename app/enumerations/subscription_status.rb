class SubscriptionStatus < EnumerateIt::Base
  associate_values :active,
                   :pending,
                   :canceled
end
