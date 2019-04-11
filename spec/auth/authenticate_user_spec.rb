require 'rails_helper'

RSpec.describe Api::Auth::AuthenticateUser do
  let(:user) { create(:users) }
  let(:unsaved_user) { build(:users) }

  subject(:valid_auth) { described_class.new(user.email, user.password) }
  subject(:invalid_auth) { described_class.new(unsaved_user.email, unsaved_user.password) }

  describe '#call' do
    context 'when user has valid credentials' do
      it 'returns an auth token' do
        token = valid_auth.call
        expect(token).not_to be_nil
      end
    end

    context 'when user has invalid credentials' do
      it 'raises an authentication error' do

        expect { invalid_auth.call }.to raise_error(
          Api::Auth::Errors::AuthenticationError,
          /Invalid credentials/
        )
      end
    end
  end
end
