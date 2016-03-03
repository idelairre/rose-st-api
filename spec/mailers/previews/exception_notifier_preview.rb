# Preview all emails at http://localhost:3000/rails/mailers/exception_notifier
class ExceptionNotifierPreview < ActionMailer::Preview
  def exception_notification
    error = ArgumentError.new('something the fuck happened')
    data = { message: "Exception: #{error}" }
    ExceptionNotifier.exception_notification(error, data)
  end
end
