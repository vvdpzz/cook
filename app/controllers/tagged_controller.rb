class TaggedController < ApplicationController
  
  set_tab :questions
  set_tab :latest,  :navigation, :only => %w(index latest)
  set_tab :active,  :navigation, :only => %w(active)
  set_tab :vote,    :navigation, :only => %w(vote)

  def index
    @questions = pagination Question.tagged_with(params[:tag]).latest
  end
  
  def latest
    @questions = pagination Question.tagged_with(params[:tag]).latest
    render :index
  end
  
  def active
    @questions = pagination Question.tagged_with(params[:tag]).active
    render :index
  end
  
  def vote
    @questions = pagination Question.tagged_with(params[:tag]).vote
    render :index
  end

end
