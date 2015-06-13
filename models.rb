Post = Struct.new(:id, :author, :body, :comments, :created_at) do
  def self.gen(id)
    comments = (1..10).to_a.map { |i| Comment.gen("#{id}-#{i}") }
    new(id.to_s, "Author Name", "Post content", comments, Time.now)
  end
end

Comment = Struct.new(:id, :author, :body, :created_at) do
  def self.gen(id)
    new(id, "Author Name", "Comment content", Time.now)
  end
end
