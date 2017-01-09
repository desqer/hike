class RegisterLead
  def self.run(*args)
    new(*args).run
  end

  def initialize(name, email)
    @name = name
    @email = email
  end

  def run
    lead.tap(&:save!)
  end

  private

  attr_reader :name, :email

  def lead
    Lead.find_or_initialize_by(name: name, email: email)
  end
end
