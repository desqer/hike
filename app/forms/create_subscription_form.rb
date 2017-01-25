class CreateSubscriptionForm
  include ActiveModel::Validations

  validates :email, :list_id, presence: true
  validates :email, format: Devise::email_regexp

  def initialize(params)
    @name = params[:name]
    @email = params[:email]
    @list_id = params[:list_id]
    @redirect_url = params[:redirect_url]
  end

  def save
    return unless valid?

    transaction do
      lead = RegisterLeadService.run(name, email)
      SubscribeLeadService.run(lead, list)
    end
  end

  def success_redirect
    AddUTMService.run(redirect_url, source: "hike", medium: "subscription", campaign: list_id)
  end

  def error_messages
    errors.full_messages
  end

  def data
    { email: email, list_id: list_id }
  end

  private

  attr_reader :name, :email, :list_id, :redirect_url

  def list
    List.find(list_id)
  end

  def transaction(&block)
    ActiveRecord::Base.transaction(&block)
  end
end
