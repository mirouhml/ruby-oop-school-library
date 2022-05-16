require_relative './app'
require_relative './student'
require_relative './book'
require_relative './teacher'
require_relative './rental'

def main
  app = App.new
  book = Book.new('Lord of the rings', 'Tolkien')
  Book.new('Harry Potter', 'Rowling')
  Book.new('Rich dad poor dad', 'Kiyosaki')
  Book.new('Atomic habits', 'Clear')
  student = Student.new(15, 'Maths', 'Mark')
  Student.new(18, 'Physics', 'Sofia')
  Student.new(14, 'Maths', 'James')
  Teacher.new(40, 'Maths', 'Jack')
  Teacher.new(65, 'Physics', 'George')
  Rental.new(Time.now, book, student)
  app.run
end

main
