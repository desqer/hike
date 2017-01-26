class API::SubscriptionConfirmationsController < APIController
  ##
  # Confirms a lead subscription
  #
  #   GET /api/subscription_confirmation/ffbf67e8-722f-4473-ac3a-3cea5ac6b061
  #
  #   {
  #     redirect_url: "http://example.com/thank_you"
  #   }
  #
  # Subscription is activated.
  # If list has attachment, downloads it
  # If redirect_url is present, redirects it
  # An error is raised if the subscription is not found.
  #
  def create
    form = ConfirmSubscriptionForm.new(params)

    form.save

    send_file form.attachment and return if form.attachment
    redirect_to form.success_redirect and return if form.success_redirect

    head :ok
  end
end
