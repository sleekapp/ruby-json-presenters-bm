require "./jbuilder/author"

CommentRepresenter = JbuilderRepresenter.new do

  representation do |json|
    json.id id
    json.body body
    json.created_at created_at
    json.author author, with: AuthorRepresenter
  end

end
