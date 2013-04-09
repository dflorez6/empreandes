# Load the rails application
require File.expand_path('../application', __FILE__)

ActionMailer::Base.smtp_settings = {
    :user_name => "jstriedinger",
    :password => "dreams2013",
    :domain => "localhost:3000",
    :address => "smtp.sendgrid.net",
    :port => 587,
    :authentication => :plain,
    :enable_starttls_auto => true
}

# Initialize the rails application
ANEU::Application.initialize!
