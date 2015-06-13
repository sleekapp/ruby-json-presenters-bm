require "benchmark"
require "oj"
require "rabl"

require "./models"

POSTS = (1..10).to_a.map { |i| Post.gen(i) }

Rabl.configure do |config|
  config.view_paths = ["./rabl_views"]
  config.include_json_root = false
  config.include_child_root = false
end

Benchmark.bmbm(7) do |bm|
  bm.report ("simple") do
    1_000.times do
      Rabl::Renderer.json(POSTS.first, "simple")
    end
  end

  bm.report("nested") do
    1_000.times do
      Rabl::Renderer.json(POSTS.first, "nested")
    end
  end

  bm.report("list") do
    1_000.times do
      Rabl::Renderer.json(POSTS, "nested")
    end
  end
end
