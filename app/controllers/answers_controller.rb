class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    @answer.save
    respond_to do |format|
      format.js
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
