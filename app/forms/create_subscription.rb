class CreateSubscription
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
      lead = RegisterLead.run(name, email)
      SubscribeLead.run(lead, list)
    end
  end

  def success_redirect
    add_utm_params redirect_url if redirect_url.present?
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

  def add_utm_params(url)
    url = URI(url)

    query = URI.decode_www_form String(url.query)
    query << ["utm_source", "hike"]
    query << ["utm_medium", "subscription"]
    query << ["utm_campaign", list_id]

    url.query = URI.encode_www_form query
    url.to_s
  end
end
