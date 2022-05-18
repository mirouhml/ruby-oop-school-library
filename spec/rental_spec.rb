require_relative '../rental'
require_relative '../book'
require_relative '../student'

describe Rental do
  context 'when testing the Rental class' do
    title = 'Lord of the rings'
    author = 'Tolkien'
    book = Book.new(title, author)
    age = '19'
    name = 'Mark'
    classroom = 'Science'
    student = Student.new(age, classroom, name)
    date = '18-05-2022'
    rental = Rental.new(date, book, student)

    it 'should validate the date of the rental' do
      expect(rental.date).to eq date
    end

    it 'should validate the book of the rental' do
      expect(rental.book.title).to eq title
    end

    it 'should validate the person of the rental' do
      expect(rental.person.name).to eq name
    end
  end
end
