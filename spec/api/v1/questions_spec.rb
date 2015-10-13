require 'rails_helper'

describe 'Questions API' do
  describe 'GET /index' do
    it_behaves_like "Api Authorizeable"

    context 'authorized' do
      let(:user){ create(:user)}
      let(:access_token){create :access_token, resource_owner_id: user.id}
      let!(:questions){ create_list(:question, 2) }
      let(:question) {questions.first}
      let!(:answer) {create :answer, question:question }

      before do
        get '/api/v1/questions', format: :json, access_token: access_token.token
      end

      it 'return 200 status code' do
        expect(response).to be_success
      end

      it 'should return list of questions' do
        expect(response.body).to have_json_size(2).at_path('questions')
      end

      %w[ id title body ].each do |attr|
        it "contains #{attr}" do
          question = questions[0]
          expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("questions/0/#{attr}")
        end
      end

      context "answers" do

        it 'included in question object' do
          expect(response.body).to have_json_size(1).at_path("questions/0/answers")
        end

        %w[ id body ].each do |attr|
          it "contains #{attr}" do
            expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("questions/0/answers/0/#{attr}")
          end
        end
      end
    end

  end
  def do_request(options = {})
    get '/api/v1/questions', {format: :json}.merge(options)
  end
end