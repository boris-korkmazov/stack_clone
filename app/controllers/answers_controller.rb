class AnswersController < ApplicationController

  before_action :authenticate_user!
  before_action :load_answer, only: :update
  after_action :publish_answer, only: :create

  respond_to :js
  #respond_to :json, only: :create
  def create
    @question = Question.find(params[:question_id])
    respond_with(@answer = @question.answers.create(answer_params))
  end

  def update
    @answer.update(answer_params)
    respond_with(@answer)
  end

  private

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file])
  end

  def publish_answer
  end

  def load_answer
    @answer = Answer.find(params[:id])
    @question = @answer.question
  end
end
