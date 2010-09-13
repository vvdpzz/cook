class Question < ActiveRecord::Base
  # NOTE: Questions belong to a user
  belongs_to :user
  
  # validations
  validate :tags_count_must_within_one_to_five
  
  # tag plugin
  acts_as_taggable
  acts_as_taggable_on :tags
  
  # vote plugin
  acts_as_voteable
  
  # scope
  scope :latest, order("created_at DESC")
  scope :active, order("updated_at DESC")
  scope :vote, order("voted DESC")
  scope :unanswered, lambda { where(["accepted = 0"]) }
  
  # return tag list
  def tagged_list
    tagged.split(/,/)
  end
  
  protected
  
    def tags_count_must_within_one_to_five
      if self.tag_list.count > 5
        errors.add(:tag_list, "can not be more than 5 tags")
      elsif self.tag_list.count == 0
        errors.add(:tag_list, "must have 1 tag at least")
      end
    end
end
