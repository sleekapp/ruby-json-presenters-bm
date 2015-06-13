require "benchmark"
require "oj"
require "rabl"

require "./models"

POSTS = (1..1000).to_a.map { |i| Post.gen(i) }

Rabl.configure do |config|
  config.view_paths = ["./rabl_views"]
  config.include_json_root = false
  config.include_child_root = false
end

puts Rabl::Renderer.json(POSTS.first, "simple")
puts Rabl::Renderer.json(POSTS.first, "nested")

Benchmark.bmbm(7) do |bm|
  bm.report ("simple") do
    10_000.times do
      Rabl::Renderer.json(POSTS.first, "simple")
    end
  end

  bm.report("nested") do
    10_000.times do
      Rabl::Renderer.json(POSTS.first, "nested")
    end
  end

  #bm.report("list") { Rabl::Renderer.json(POSTS, "list") }
end
