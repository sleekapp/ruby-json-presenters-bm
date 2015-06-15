AuthorRepresenter = JbuilderRepresenter.new do

  representation do |json|
    json.id id
    json.name name
  end

end
