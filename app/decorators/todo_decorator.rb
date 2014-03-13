class TodoDecorator
  extend Forwardable

  def_delegators :todo, :name_only?

  attr_reader :todo

  def initialize(todo)
    @todo = todo
  end

  def display_text
    todo.name + tag_text
  end


  private
    def tag_text
      if todo.tags.any?
        " (#{tags.one? ? 'tag' : 'tags'}: #{tags.map(&:name).first(4).join(", ")}#{', more...' if tags.count > 4})"
      else
        ""
      end
end
