ActionMailer::Base.smtp_settings = {
  user_name: "SMTP_Injection",
  password: Rails.application.secrets.sparkpost_key,
  address: "smtp.sparkpostmail.com",
  port: 587,
  enable_starttls_auto: true,
  format: :html
}
