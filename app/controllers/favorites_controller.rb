class FavoritesController < ApplicationController
  
  before_filter :authenticate_user!
  
  def create
    favorite = current_user.favorites.find_by_question_id(params[:id])
    question = Question.find_by_id(params[:id])
    if favorite
      save_event(s=current_user,e='destroy_favorite',t=favorite)
      favorite.destroy
      question.update_attributes(:favorited => question.favorited-1)
      @favorite = false
      @favorited = question.favorited
    else
      favorite = current_user.favorites.build(:question_id => params[:id])
      favorite.save
      question.update_attributes(:favorited => question.favorited+1)
      @favorite = true
      @favorited = question.favorited
      save_event(s=current_user,e='create_favorite',t=favorite)
    end
  end
  
end
