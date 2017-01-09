class CreateSubscription
  include ActiveModel::Validations

  validates :name, :email, presence: true
  validates :email, format: Devise::email_regexp

  def initialize(params)
    @name = params[:name]
    @email = params[:email]
    @list_id = params[:list_id]
  end

  def save
    return unless valid?

    transaction do
      lead = RegisterLead.run(name, email)
      SubscribeLead.run(lead, list)
    end
  end

  def error_messages
    errors.full_messages
  end

  def data
    { name: name, email: email }
  end

  private

  attr_reader :name, :email, :list_id

  def list
    List.find(list_id)
  end

  def transaction(&block)
    ActiveRecord::Base.transaction(&block)
  end
end
