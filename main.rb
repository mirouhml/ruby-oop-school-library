require_relative './person'
require_relative './student'
require_relative './classroom'
require_relative './book'

classroom = Classroom.new('Math')
student = Student.new(17, classroom, 'Ammar', parent_permission: false)

puts(student.classroom.label)
puts(classroom.students[0].name)

person2 = Person.new(18, 'Joe')
book = Book.new('Title', 'Author')

book.add_rental('10-05-2022', person2)
puts("#{book.rentals.first.person.name} rented #{book.rentals.first.book.title} on #{book.rentals.first.date}")
