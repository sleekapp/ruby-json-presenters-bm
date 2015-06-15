require "benchmark"

require "oj"
require "multi_json"

require "./models"
require "./jbuilder/representer"
require "./jbuilder/simple"
require "./jbuilder/nested"

POSTS = (1..10).to_a.map { |i| Post.gen(i) }

Benchmark.bmbm(7) do |bm|
  bm.report ("simple") do
    1_000.times do
      SimpleRepresenter.new(POSTS.first).to_json
    end
  end

  bm.report("nested") do
    1_000.times do
      NestedRepresenter.new(POSTS.first).to_json
    end
  end

  bm.report("list") do
    1_000.times do
      posts = POSTS.map { |post| NestedRepresenter.new(post).to_hash }
      MultiJson.dump(posts)
    end
  end
end
