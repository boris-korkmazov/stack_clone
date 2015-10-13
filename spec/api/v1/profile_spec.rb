require 'rails_helper'

describe 'Describe API' do
  describe 'GET /me' do
    it_behaves_like "Api Authorizeable"

    context 'authorized' do
      let(:me) { create :user }
      let(:access_token) {create :access_token, resource_owner_id: me.id}

      before { get '/api/v1/profiles/me', format: :json, access_token: access_token.token }

      it 'returns 200 status' do
        expect(response.status).to eq 200
      end

      %w[ id email ].each do |attr|
        it "contains #{attr}" do
          expect(response.body).to be_json_eql(me.send(attr.to_sym).to_json).at_path(attr)
        end
      end


      it 'does not contains password' do
        expect(response.body).not_to have_json_path('password')
      end
    end
  end
  def do_request(options = {})
    get '/api/v1/profiles/me', {format: :json}.merge(options)
  end
end