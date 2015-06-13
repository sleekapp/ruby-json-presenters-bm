attribute :id
attribute :body
attribute :created_at

node(:author_id) { |post| post.author.id }
node(:comment_ids) { |post| post.comments.map(&:id) }
