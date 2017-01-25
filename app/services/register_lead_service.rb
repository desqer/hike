class RegisterLeadService
  def self.run(*args)
    new(*args).run
  end

  def initialize(name, email)
    @name = name
    @email = email
  end

  def run
    lead.name = name if name.present?
    lead.tap(&:save!)
  end

  private

  attr_reader :name, :email

  def lead
    @lead ||= Lead.find_or_initialize_by(email: email)
  end
end
