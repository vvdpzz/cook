class UsersController < ApplicationController

  def index
    @users = pagination User.all
  end
  
  def oldest
    @users = pagination User.oldest
    render :index
  end
  
  def show
    @user = User.find(params[:id])
    @questions = pagination(@user.questions,5)
    @answers = pagination(@user.answers,5)
  end
  
end
