shared_examples_for "Api Authorizeable" do
  context 'unauthorized' do
    it 'returns 401 status if there is no access_token' do
      do_request
      expect(response.status).to eq 401
    end

    it 'returns 401 status if access_token invalid' do
      do_request(access_token: '123456')
      expect(response.status).to eq 401
    end
  end
end