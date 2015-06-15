require "./jbuilder/author"
require "./jbuilder/comment"

NestedRepresenter = JbuilderRepresenter.new do

  representation do |json|
    json.id id
    json.body body
    json.created_at created_at
    json.author author_builder
    json.comments comments do |c|
      json.merge! comment_builder(c)
    end
  end

  private

  def author_builder
    AuthorRepresenter.new(author).to_hash
  end

  def comment_builder(comment)
    CommentRepresenter.new(comment).to_hash
  end

end
