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
      rentals[index] = { :date => r.date, :book_title => r.book.title, :person_id => r.person.id}
    end
    rentals = rentals.to_json
    File.open("data/rentals.json","w") do |f|
      f.write(rentals)
    end
    rentals
  end

  def self.restore_rentals(books, people)
    if File.exist?('data/rentals.json') && !File.zero?('data/rentals.json')
      file = File.open('data/rentals.json','r')
      file_json = JSON.parse(file.read)
      file_json.each_key do |key|
        book = ''
        books.each do |b|
          book = b if b.title == file_json[key]['book_title']
        end
        person = ''
        people.each do |p|
          person = p if p.id == file_json[key]['person_id']
        end
        new(file_json[key]['date'], book, person)
      end
    end
  end
end
