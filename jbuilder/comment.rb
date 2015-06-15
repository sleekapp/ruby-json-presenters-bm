CommentRepresenter = JbuilderRepresenter.new do

  representation do |json|
    json.id id
    json.body body
    json.created_at created_at
    json.author author_builder
  end

  def author_builder
    AuthorRepresenter.new(author).to_builder
  end

end
