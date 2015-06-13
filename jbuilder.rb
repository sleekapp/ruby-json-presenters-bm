require "benchmark"

require "oj"
require "multi_json"

require "jbuilder"

require "./models"

POSTS = (1..10).to_a.map { |i| Post.gen(i) }

def simple(p)
  Jbuilder.new do |json|
    json.id p.id
    json.body p.body
    json.created_at p.created_at
    json.author_id p.author.id
    json.comment_ids p.comments.map(&:id)
  end
end

def nested(p)
  Jbuilder.new do |json|
    json.id p.id
    json.body p.body
    json.created_at p.created_at
    json.author author(p.author)
    json.comments p.comments do |c|
      json.id c.id
      json.body c.body
      json.created_at c.created_at
      json.author author(c.author)
    end
  end
end

def author(a)
  Jbuilder.new do |json|
    json.id a.id
    json.name a.name
  end
end

Benchmark.bmbm(7) do |bm|
  bm.report ("simple") do
    1_000.times do
      simple(POSTS.first).target!
    end
  end

  bm.report("nested") do
    1_000.times do
      nested(POSTS.first).target!
    end
  end

  bm.report("list") do
    1_000.times do
      posts = POSTS.map { |post| nested(post).attributes! }
      MultiJson.dump(posts)
    end
  end
end
