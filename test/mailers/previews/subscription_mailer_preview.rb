# Preview all emails at http://localhost:3000/rails/mailers/subscription_mailer
class SubscriptionMailerPreview < ActionMailer::Preview
  def response_email_preview
    SubscriptionMailer.response_email(Subscription.first)
  end
end
