SimpleRepresenter = JbuilderRepresenter.new do

  representation do |json|
    json.id id
    json.body body
    json.created_at created_at
    json.author_id author.id
    json.comment_ids comment_ids
  end

  private

  def comment_ids
    comments.map(&:id)
  end

end
