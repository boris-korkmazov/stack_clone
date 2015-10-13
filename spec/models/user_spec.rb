require 'rails_helper'

RSpec.describe User do
  it {should validate_presence_of :email}
  it {should validate_presence_of :password}

  describe '.find_for_oauth' do
    let!(:user) {create :user }

    let(:auth) {OmniAuth::AuthHash.new(provider: 'facebook', uid: '12345')}

    context 'user already has authorization' do
      it 'should return the user' do
        user.authorizations.create(provider: 'facebook', uid: '12345')

        expect(User.find_for_oauth(auth)).to eq user
      end
    end

    context 'user has not authorization' do
      context 'user already exists' do
        let(:auth) {OmniAuth::AuthHash.new(provider: 'facebook', uid: '12345', info:{email: user.email})}

        it 'does not create new user' do
          expect{ User.find_for_oauth(auth) }.to_not change(User, :count)
        end

        it 'creates authorization for user ' do
          expect{ User.find_for_oauth(auth) }.to change(user.authorizations, :count).by(1)
        end

      end
    end
  end
end