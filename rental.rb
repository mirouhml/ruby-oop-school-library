require_relative './book'
require_relative './person'

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

  def self.store_rentals
    rentals = {}
    @@rentals.each_with_index do |r, index|
      rentals[index] = { date: r.date, book_title: r.book.title, person_id: r.person.id }
    end
    rentals = rentals.to_json
    File.write('data/rentals.json', rentals)
    rentals
  end

  def self.restore_rentals(_books, _people)
    return unless File.exist?('data/rentals.json') && !File.zero?('data/rentals.json')

    file = File.open('data/rentals.json', 'r')
    file_json = JSON.parse(file.read)
    file_json.each_key do |key|
      book = Book.get_book(file_json[key]['book_title'])
      person = Person.get_person(file_json[key]['person_id'])
      new(file_json[key]['date'], book, person)
    end
  end
end
