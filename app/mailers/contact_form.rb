class ContactForm < ApplicationMailer
  default from: 'contact@rosestreetcc.com'

  def contact(data)
    @name = data[:name]
    @email = data[:email]
    @message = data[:message]
    mail(to: ENV['ADMIN_EMAIL'], subject: "Rose St. App: message from #{@name}")
  end
end
