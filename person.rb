class Person
  attr_reader :id
  attr_accessor :name, :age

  def initialize(age, name = 'unknown', parent_permission: true)
    @id = Random.rand(1..10_000)
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  def of_age?
    return true if @age > 17

    false
  end

  def can_use_services?
    return true if @parent_permission || of_age?

    false
  end

  private :of_age?
end
