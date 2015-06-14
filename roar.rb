require "benchmark"
require "oj"
require "roar/json"

require "./models"

POSTS = (1..10).to_a.map { |i| Post.gen(i) }

module SimpleRepresenter
  include Roar::JSON

  property :id
  property :body
  property :created_at
  property :author_id
  property :comment_ids

  def author_id
    author.id
  end

  def comment_ids
    comments.map(&:id)
  end
end

module AuthorRepresenter
  include Roar::JSON

  property :id
  property :name
end

module NestedRepresenter
  include Roar::JSON

  property :id
  property :body
  property :created_at

  property :author, extend: AuthorRepresenter

  collection :comments do
    property :id
    property :body
    property :created_at
    property :author, extend: AuthorRepresenter
  end
end

module ListRepresenter
  include Roar::JSON

  collection :items, extend: NestedRepresenter

  def items
    self
  end
end

Benchmark.bmbm(7) do |bm|
  bm.report ("simple") do
    1_000.times do
      POSTS.first.extend(SimpleRepresenter).to_json
    end
  end

  bm.report("nested") do
    1_000.times do
      POSTS.first.extend(NestedRepresenter).to_json
    end
  end

  bm.report("list") do
    1_000.times do
      POSTS.extend(ListRepresenter).to_json
    end
  end
end
