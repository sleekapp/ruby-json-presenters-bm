require "./jbuilder/author"
require "./jbuilder/comment"

NestedRepresenter = JbuilderRepresenter.new do

  representation do |json|
    json.id id
    json.body body
    json.created_at created_at
    json.author author, with: AuthorRepresenter
    json.comments comments, with: CommentRepresenter
  end

end
