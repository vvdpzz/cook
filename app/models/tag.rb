class Tag < ActsAsTaggableOn::Tag
  def count
    Question.tagged_with(self).count
  end
  scope :nameabc, order("name ASC")
end