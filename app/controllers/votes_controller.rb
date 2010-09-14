class VotesController < ApplicationController
  def vote_up
    @voteable = params[:voteable].to_s.classify.constantize
		@voted = @voteable.find(params[:id])
		before = @voted.plusminus
		current_user.vote_exclusively_for @voted
		set_voted @voted
		after = @voted.plusminus
		if before != after
		  save_event(s=current_user,e='vote_up',t=@voted)
	  end
  end

  def vote_down
    @voteable = params[:voteable].to_s.classify.constantize
		@voted = @voteable.find(params[:id])
		before = @voted.plusminus
		current_user.vote_exclusively_against @voted
    set_voted @voted
    after = @voted.plusminus
    if before != after
		  save_event(s=current_user,e='vote_down',t=@voted)
	  end
  end
end
