# Preview all emails at http://localhost:3000/rails/mailers/subscription_mailer
class SubscriptionMailerPreview < ActionMailer::Preview
  def confirmation_email_preview
    SubscriptionMailer.confirmation_email(Subscription.first, "http://example.com")
  end
end
