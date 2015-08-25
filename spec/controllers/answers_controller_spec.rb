require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let!(:question) do
    create :question
  end
  describe 'POST #create' do
    context 'with valid attributes' do
      it 'save new answer in the database' do
        expect{post :create, format: :js, question_id: question, answer: attributes_for(:answer)}.to change(question.answers, :count).by(1)
      end

      it 'redirect to show view' do
        post :create, format: :js, question_id: question, answer: attributes_for(:answer)
        expect(response).to render_template :create
      end
    end

    context 'with invalid attributes' do
      it 'does not save the question' do
        expect { post :create, format: :js, question_id: question, answer: attributes_for(:invalid_answer)}.to_not change(question.answers, :count)
      end

      it 're render new view' do
        post :create, format: :js, question_id: question, answer: attributes_for(:invalid_answer)

        expect(response).to render_template :create
      end
    end
  end
end
