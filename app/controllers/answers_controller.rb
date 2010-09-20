class AnswersController < ApplicationController

  before_filter :authenticate_user!, :load_basics

  def new
    @answer = current_user.answers.build
  end

  def edit
    @answer = current_user.answers.find(params[:id])
  end

  def create
    @answer = current_user.answers.build(params[:answer])
    @answer.question_id = @question.id
    @answer.html_body = BlueCloth.new(coderay(@answer.body)).to_html
    if @answer.save
      save_event(s=current_user,e='create_answer',t=@answer)
      redirect_to @question
    else
      render :new
    end
  end

  def update
    @answer = current_user.answers.find(params[:id])
    @answer.html_body = BlueCloth.new(coderay(params[:answer][:body])).to_html
    if @answer.update_attributes(params[:answer])
      save_event(s=current_user,e='update_answer',t=@answer)
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    @answer = current_user.answers.find(params[:id])
    save_event(s=current_user,e='destroy_answer',t=@answer)
    @answer.destroy
    redirect_to @question
  end
  
  private
    def load_basics
      @question = Question.find(params[:question_id])
    end
end
