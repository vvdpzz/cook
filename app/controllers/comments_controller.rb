class CommentsController < ApplicationController
  def new
    @qora = Question.find(params[:question_id])
    if params[:answer_id]
      @qora = Answer.find(params[:answer_id])
    end
  end

  def create
    @commentable = params[:commentable].to_s.classify.constantize
		@qora = @commentable.find(params[:id])
    @comment = @qora.comments.build(:user_id  => current_user.id, :body => params[:body].to_s)
    @comment.save
    save_event(s=current_user,e='create_comment',t=@comment)
  end

end
