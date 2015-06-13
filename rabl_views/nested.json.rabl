attributes :id, :author, :body, :created_at
collection :comments
child :comments do
  extends "comment"
end
