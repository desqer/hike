class SubscriptionMailer < ApplicationMailer
  def confirmation_email(subscription, redirect_url)
    renderer = SubscriptionMailRenderer.new(subscription, redirect_url)

    mail to: subscription.lead_email,
         subject: 'Obrigado ;)',
         content_type: "text/html",
         body: renderer.call
  end
end
