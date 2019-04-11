require 'rails_helper'

RSpec.describe API::Auth::AuthorizeRequest do
  let(:user) { create(:users) }

  describe '#call' do
    context 'when the request is valid' do
      let(:header) { { 'Authorization' => token_generator(user.id) } }
      subject(:request) { described_class.new(header) }

      it 'returns a user' do
        result = request.call

        expect(result[:user]).to eq(user)
      end
    end

    context 'when the request is invalid' do
      context 'when missing token' do
        subject(:invalid_request) { described_class.new({}) }

        it 'raises a MissingToken error' do
          expect { invalid_request.call }.to raise_error(
            API::Auth::Errors::MissingToken,
            'Missing token'
          )
        end
      end

      context 'when invalid token' do
        let(:invalid_header) { { 'Authorization' => token_generator(5) } }
        subject(:invalid_request) { described_class.new(invalid_header) }

        it 'raises an InvalidToken error' do
          expect { invalid_request.call }.to raise_error(
            API::Auth::Errors::InvalidToken,
            /Invalid token/
          )
        end
      end

      context 'when token is expired' do
        let(:header) {{ 'Authorization' => expired_token_generator(user.id) }}
        subject(:request) { described_class.new(header) }

        it 'raises an error' do
          expect { request.call }.to raise_error(
            API::Auth::Errors::InvalidToken,
            /Signature has expired/
          )
        end
      end

      context 'when token is fake' do
        let(:header) { { 'Authorization' => 'foobar' } }
        subject(:invalid_request) { described_class.new(header) }

        it 'handles JWT::DecodeError' do
          expect { invalid_request.call }.to raise_error(
            API::Auth::Errors::InvalidToken,
            /Not enough or too many segments/
          )
        end
      end
    end
  end
end
