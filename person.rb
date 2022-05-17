require_relative './nameable'
require_relative './rental'

class Person < Nameable
  attr_reader :id, :rentals, :parent_permission
  attr_accessor :name, :age

  # rubocop:disable Style/ClassVars
  @@people = []
  # rubocop:enable Style/ClassVars
  def initialize(age, name = 'unknown', parent_permission: true)
    super()
    @id = Random.rand(1..10_000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
    @@people.push(self)
  end

  def of_age?
    return true if @age > 17

    false
  end

  def can_use_services?
    return true if @parent_permission || of_age?

    false
  end

  def correct_name
    @name
  end

  def add_rental(date, book)
    rental = Rental.new(date, book, self)
    @rentals.push(rental)
  end

  private :of_age?
end
