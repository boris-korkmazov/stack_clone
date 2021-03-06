require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { create(:question) }

  describe 'GET #index' do

    let(:questions){
      create_list(:question, 2)
    }

    before do

      get :index

    end

    it 'populates an array of all questions' do

      expect(assigns[:questions]).to match_array @questions

    end

    it 'renders index view' do

      expect(response).to render_template :index

    end
  end

  describe 'GET #show' do

    before do

      get :show, id: question

    end

    it 'assigns the requested question to @question' do

      expect(assigns[:question]).to eq question

    end

    it 'assigns new answer for question' do
      expect(assigns[:answer]).to be_a_new Answer
    end

    it 'renders show view' do

      expect(response).to render_template :show

    end
  end

  describe 'GET #new' do

    sign_in_user

    before do

      get :new

    end

    it 'assigns a new Question to @question' do
      expect(assigns[:question]).to be_a_new Question
    end


    it 'renders new view' do
      expect(response).to render_template :new
    end

  end

  describe 'GET #edit' do

    sign_in_user

    before do

      get :edit, id: question

    end

    it 'assigns the requested question to @question' do

      expect(assigns[:question]).to eq question

    end

    it 'renders show view' do

      expect(response).to render_template :edit

    end
  end

  describe 'POST #create' do

    sign_in_user

    context 'with valid attributes' do
      it 'saves the new question in the database' do
        expect { post :create, question: attributes_for(:question)}.to change(Question, :count)
      end

      it 'redirect to show view' do
        post :create, question: attributes_for(:question)

        expect(response).to redirect_to question_path(assigns[:question])
      end
    end

    context 'with invalid attributes' do
      it 'does not save the question' do
        expect { post :create,  question: attributes_for(:invalid_question)}.to_not change(Question, :count)
      end

      it 're render new view' do
        post :create, question: attributes_for(:invalid_question)

        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do

    sign_in_user

    context 'with valid attributes' do
      it 'assigns the requested question to @question' do
        patch :update, id: question, question: attributes_for(:question)
        expect(assigns[:question]).to eq question
      end

      it 'changes question attributes' do
        patch :update, id: question, question: {title: 'new title', body: 'new body'}
        question.reload
        expect(question.title).to eq 'new title'
        expect(question.body).to eq 'new body'
      end

      it 'redirects to the updated question' do
        patch :update, id: question, question: attributes_for(:question)
        expect(response).to redirect_to question
      end
    end
    context 'with invalid attributes' do
      before {
        patch :update, id: question, question: {title: 'new title', body: nil}
      }
      it 'does not change question attributes' do
        question.reload

        expect(question.title).to_not eq 'new title'

        expect(question.body).to_not eq nil
      end

      it 're-render edit template' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do

    sign_in_user

    it 'delete question' do
      question
      expect {delete :destroy, id: question}.to change(Question, :count).by -1
    end

    it 'redirect to index view' do
      delete :destroy, id: question
      expect(response).to redirect_to questions_path
    end
  end

end
