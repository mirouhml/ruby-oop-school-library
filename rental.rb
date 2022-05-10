class Rental
  attr_accessor :date
  attr_reader :book, :person

  # rubocop:disable Style/ClassVars
  @@rentals = []
  # rubocop:enable Style/ClassVars
  def initialize(date, book, person)
    @date = date
    @book = book
    @person = person
    @@rentals.push(self)
  end
end
