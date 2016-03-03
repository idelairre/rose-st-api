require 'rails_helper'
require 'spec_helper'

include Devise::TestHelpers

RSpec.describe Devise::mailer, type: :mailer do
  before(:all) do
    @user = FactoryGirl.create(:user)
  end
  describe '#confirmation_instructions' do
    it 'should not raise an error' do
      expect { FactoryGirl.create(:user) }.to_not raise_error
    end

    it 'should increase the number of delived emails by 1' do
      expect { Devise::mailer.confirmation_instructions(@user, :confirmation_instructions).deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it 'should have configured headers' do
      mail = Devise::mailer.confirmation_instructions(@user, :confirmation_instructions).deliver_now
      expect(mail.to_s).to match('mailer@rosestreet.org')
    end
  end
end
