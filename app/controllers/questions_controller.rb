class QuestionsController < ApplicationController
  
  before_filter :authenticate_user!, :only => [:new, :edit, :create, :update, :destroy]
  
  autocomplete :tag, :name, :full => true
  
  set_tab :questions
  set_tab :ask, :only => %w(new)
  set_tab :latest,  :navigation, :only => %w(index latest)
  set_tab :active,  :navigation, :only => %w(active)
  set_tab :vote,    :navigation, :only => %w(vote)
  
  set_tab :answer_latest, :navigation, :only => %w(answer_latest)
  set_tab :answer_oldest, :navigation, :only => %w(answer_oldest)
  set_tab :answer_vote,   :navigation, :only => %w(show answer_vote)

  def index
    @questions = pagination Question.latest
  end

  def latest
    @questions = pagination Question.latest
    render :index
  end
  
  def active
    @questions = pagination Question.active
    render :index
  end
  
  def vote
    @questions = pagination Question.vote
    render :index
  end
  
  def answer_latest
    @question = Question.find(params[:id])
    @answers = pagination @question.answers.latest
    render :show
  end
  
  def answer_vote
    @question = Question.find(params[:id])
    @answers = pagination @question.answers.vote
    render :show
  end
  
  def accept
    question = Question.find(params[:id])
    question.update_attributes( :accepted => params[:accept] )
    
    # hack
    answer = Answer.find(params[:accept])
    answer.update_attributes( :voted => answer.voted + 27367, :created_at => -2010.years.ago(answer.created_at) )
    
    save_event(s=current_user,e='accept',t=answer)
    
    redirect_to question
  end
  
  def show
    @question = Question.find(params[:id])
    @answers = pagination @question.answers.vote
    # update viewed
    if session["viewed_#{@question.id}"] == nil
      session["viewed_#{@question.id}"] = 1
      @question.update_attributes(:viewed => @question.viewed+1)
    end
  end

  def new
    @question = current_user.questions.build
  end

  def edit
    @question = Question.find(params[:id])
  end

  def create
    @question = current_user.questions.build(params[:question])
    @question.html_body = BlueCloth.new(coderay(@question.body)).to_html

    if @question.save
      redirect_to(@question, :notice => 'Question was successfully created.')
    else
      render :new
    end
  end

  def update
    @question = Question.find(params[:id])
    @question.html_body = BlueCloth.new(coderay(params[:question][:body])).to_html
    @question.save

    if @question.update_attributes(params[:question])
      redirect_to(@question, :notice => 'Question was successfully updated.')
    else
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    redirect_to(questions_url)
  end
end
