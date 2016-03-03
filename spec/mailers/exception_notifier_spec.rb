require 'rails_helper'
require 'spec_helper'

RSpec.describe ExceptionNotifier, type: :mailer do
  describe '#exception_notification' do
    before do
      @error = ArgumentError.new('something the fuck happened')
      @data = { message: "Exception: #{@error}" }
      @email = ExceptionNotifier.exception_notification(@error, @data).deliver_now
    end

    it 'sends an email' do
      expect { ExceptionNotifier.exception_notification(@error, @data).deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it 'renders the email' do
      expect(@email.subject).to eql('rose street app error')
    end

    it 'renders the reciever' do
      expect(@email.to).to include('idelairre@gmail.com')
    end

    it 'assigns @error' do
      expect(@email.body.encoded).to match('something the fuck happened')
    end

    it 'assigns @data' do
      expect(@email.body.encoded).to match("Exception: #{@error}")
    end
  end
end
