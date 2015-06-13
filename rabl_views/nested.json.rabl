attribute :id
attribute :body
attribute :created_at

child(:author) { extends "author" }
child(:comments) { extends "comment" }
