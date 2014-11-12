ActionMailer::Base.smtp_settings = {
  user_name: ENV['SENDGRID_USERNAME'],
  password: ENV['SENDGRID_PASSWORD'],
  address: "smtp.sendgrid.net",
  port: 587,
  enable_starttls_auto: true,
  domain: "heroku.com",
  authentication: :plain
}
