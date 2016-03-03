class Utility < ActiveRecord::Base
  # logs and emails exception
  # optional args:
  # request: request used for the ExceptionNotifier
  # info: a descriptive message
  def self.log_exception(error, args)
    extra_info = args[:info]

    Rails.logger.error extra_info if extra_info
    Rails.logger.error error.message
    stack_trace = error.backtrace.join('\n')
    Rails.logger.error stack_trace

    extra_info ||= "<NO DETAILS>"
    request = args[:request]
    ExceptionNotifier.exception_notification(error, :data => {:message => "Exception: #{extra_info}"}).deliver_now
  end
end
