class SubscriptionMailer < ApplicationMailer
  def response_email(subscription)
    renderer = SubscriptionMailRenderer.new(subscription)

    mail to: subscription.lead_email,
         subject: 'Obrigado ;)',
         content_type: "text/html",
         body: renderer.call
  end
end
