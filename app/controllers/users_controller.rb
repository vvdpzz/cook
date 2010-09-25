class UsersController < ApplicationController
  
  set_tab :users
  
  set_tab :rp,      :navigation, :only => %w(index rp)
  set_tab :oldest,  :navigation, :only => %w(oldest)  
  

  def index
    @users = pagination User.rp
  end
  
  def oldest
    @users = pagination User.oldest
    render :index
  end
  
  def rp
    @users = pagination User.rp
    render :index
  end
  
  def show
    @user = User.find(params[:id])
    @questions = pagination(@user.questions,5)
    @answers = pagination(@user.answers,5)
  end
  
end
