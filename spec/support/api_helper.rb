module ApiHelper
  def unauthorized_spec(url)
    it 'returns 401 status if there is no access_token' do
      get url, format: :json
      expect(response.status).to eq 401
    end

    it 'returns 401 status if access_token invalid' do
      get url, format: :json, access_token: '12345'
      expect(response.status).to eq 401
    end
  end
end