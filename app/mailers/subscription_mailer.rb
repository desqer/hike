class SubscriptionMailer < ApplicationMailer
  def confirmation_email(subscription, redirect_url)
    mail to: subscription.lead_email,
         from: subscription.list_email_from,
         subject: subscription.list_email_subject,
         content_type: "text/html",
         body: SubscriptionMailRenderer.call(subscription, redirect_url),
         sparkpost_data: { html_content_only: true }
  end
end
