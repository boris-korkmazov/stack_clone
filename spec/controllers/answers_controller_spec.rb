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

  describe 'PATCH #update' do
    let!(:answer){
      create :answer, question: question
    }
    it 'assigns the requested answer to @answer' do
      patch :update, question_id: question, id: answer, answer: attributes_for(:answer), format: :js
      expect(assigns[:answer]).to eq answer
    end

    it 'assigns the requested question to @question' do
      patch :update, question_id: question, id: answer, answer: attributes_for(:answer), format: :js
      expect(assigns[:question]).to eq question
    end

    it 'changes question attributes' do
      patch :update, question_id: question, id: answer, answer: {body: 'new body'}, format: :js
      answer.reload
      expect(answer.body).to eq 'new body'
    end

    it 'render the update template' do
      patch :update, question_id: question, id: answer, answer: attributes_for(:answer), format: :js
      expect(response).to render_template :update
    end
  end
end
