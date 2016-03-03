class ExceptionNotifier < ApplicationMailer
  default from: 'logger@rosestreet.org'

  def exception_notification(error, data)
    @error = error
    @data = data
    mail(to: 'idelairre@gmail.com', subject: 'rose street app error')
  end
end
