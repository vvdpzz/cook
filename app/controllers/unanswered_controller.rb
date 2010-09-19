class UnansweredController < ApplicationController

  def index
    @questions = pagination Question.unanswered.latest
  end
  
  def latest
    @questions = pagination Question.unanswered.latest
    render :index
  end
  
  def active
    @questions = pagination Question.unanswered.active
    render :index
  end
  
  def vote
    @questions = pagination Question.unanswered.vote
    render :index
  end
  
end
