require_relative './rental'

class Book
  attr_accessor :title, :author
  attr_reader :rentals

  # rubocop:disable Style/ClassVars
  @@books = []
  # rubocop:enable Style/ClassVars
  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
    @@books.push(self)
  end

  def add_rental(date, person)
    rental = Rental.new(date, self, person)
    @rentals.push(rental)
  end

  def self.store_books
    books = {}
    @@books.each_with_index do |b, index|
      books[index] = { title: b.title, author: b.author }
    end
    books = books.to_json
    File.write('data/books.json', books)
    books
  end

  def self.restore_books
    return unless File.exist?('data/books.json') && !File.zero?('data/books.json')

    file = File.open('data/books.json', 'r')
    file_json = JSON.parse(file.read)
    file_json.each_key { |key| new(file_json[key]['title'], file_json[key]['author']) }
  end

  def self.get_book(title)
    book = ''
    @@books.each { |b| book = b if b.title == title }
    book
  end
end
