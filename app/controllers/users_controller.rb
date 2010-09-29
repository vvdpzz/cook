class UsersController < ApplicationController
  
  before_filter :find_user, :only => [:show, :edit, :update]
  
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
    @questions = pagination(@user.questions,5)
  end
  
  def edit
    @profile = @user.profile
  end
  
  def update
    @profile = @user.profile
    if @profile.update_attributes(params[:profile])
      redirect_to @user
    else
      render :edit
    end
  end
  
  protected
    def find_user
      @user = User.find(params[:id])
    end
  
end
