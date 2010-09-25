class UnansweredController < ApplicationController
  
  set_tab :unanswered
  set_tab :latest,  :navigation, :only => %w(index latest)
  set_tab :active,  :navigation, :only => %w(active)
  set_tab :vote,    :navigation, :only => %w(vote)

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
