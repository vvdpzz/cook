class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  
  # validations
  # validates_presence_of :body,  :on => :create, :message => "can't be blank"
  # validates_length_of   :body,  :minimum => 15, :too_short => "please enter at least 15 character"
  
  # vote plugin
  acts_as_voteable
  
  # comment plugin
  acts_as_commentable
  
  # Answer Scope
  scope :latest, order("created_at DESC")
  scope :oldest, order("created_at ASC")
  scope :vote, order("voted DESC")
  
  # set answered
  after_save :set_answered
  
  private
    def set_answered
      self.question.answered = self.question.answers.size
      self.question.save
    end
    
end
