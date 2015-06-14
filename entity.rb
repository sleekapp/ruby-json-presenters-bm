require "benchmark"
require "oj"
require "grape-entity"

require "./models"

POSTS = (1..10).to_a.map { |i| Post.gen(i) }

class SimpleRepresenter < Grape::Entity
  expose :id
  expose :body
  expose :created_at

  expose :author_id do |post|
    post.author.id
  end

  expose :comment_ids do |post|
    post.comments.map(&:id)
  end
end

class AuthorRepresenter < Grape::Entity
  expose :id
  expose :name
end

class CommentRepresenter < Grape::Entity
  expose :id
  expose :body
  expose :created_at
  expose :author, using: AuthorRepresenter
end

class NestedRepresenter < Grape::Entity
  expose :id
  expose :body
  expose :created_at

  expose :author, using: AuthorRepresenter
  expose :comments, using: CommentRepresenter
end

class ListRepresenter < Grape::Entity
  present_collection true, :items
  expose :items, using: NestedRepresenter
end

Benchmark.bmbm(7) do |bm|
  bm.report ("simple") do
    1_000.times do
      SimpleRepresenter.represent(POSTS.first, serializable: true)
    end
  end

  bm.report("nested") do
    1_000.times do
      NestedRepresenter.represent(POSTS.first, serializable: true)
    end
  end

  bm.report("list") do
    1_000.times do
      ListRepresenter.represent(POSTS, serializable: true)
    end
  end
end
