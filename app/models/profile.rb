class Profile < ActiveRecord::Base
  belongs_to :user
  
  # return particular user's full name
  def full_name
    last_name + first_name
  end
  
end
