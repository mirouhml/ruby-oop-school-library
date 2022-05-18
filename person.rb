require_relative './nameable'
require_relative './rental'

class Person < Nameable
  attr_reader :id, :rentals, :parent_permission
  attr_accessor :name, :age

  # rubocop:disable Style/ClassVars
  @@people = []
  # rubocop:enable Style/ClassVars
  def initialize(age, name = 'unknown', id = Random.rand(1..10_000))
    super()
    @id = id
    @name = name
    @age = age
    @rentals = []
    @@people.push(self)
  end

  def correct_name
    @name
  end

  def add_rental(date, book)
    rental = Rental.new(date, book, self)
    @rentals.push(rental)
  end

  def self.get_person(id)
    person = ''
    @@people.each { |p| person = p if p.id == id }
    person
  end
end
