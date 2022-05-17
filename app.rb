require_relative './person'
require_relative './student'
require_relative './book'
require_relative './teacher'
require_relative './rental'
require 'json'

class App
  def initialize
    @books = Book.class_variable_get(:@@books)
    @people = Person.class_variable_get(:@@people)
    @rentals = Rental.class_variable_get(:@@rentals)
    Book.restore_books
    Student.restore_students
    Teacher.restore_teachers
    Rental.restore_rentals(@books,@people)
  end

  def run
    puts 'Welcome to School Library App!'
    loop do
      puts "
          1 | List all books
          2 | List all people
          3 | Create a person
          4 | Create a book
          5 | Create a rental
          6 | List all rentals for a given person id
          7 | Exit"
      puts "\nSelect an option: "
      user_input = gets.chomp.to_i
      if user_input >= 7
        store_data
        break
      end

      puts "\n"
      options user_input
    end
  end

  def options(option)
    case option
    when 1
      list_books
    when 2
      list_people
    when 3
      create_person
    when 4
      create_book
    when 5
      create_rental
    when 6
      list_rentals
    else
      puts 'Unknown option'
    end
  end

  def display_books
    @books.each_with_index do |b, index|
      puts "#{index + 1} | #{b.title} - By #{b.author}"
    end
  end

  def display_people
    @people.each_with_index do |p, index|
      puts "#{index + 1} [Student] | ID: #{p.id} - Name: #{p.name} - Age: #{p.age}" if p.is_a?(Student)
      puts "#{index + 1} [Teacher] | ID: #{p.id} - Name: #{p.name} - Age: #{p.age}" if p.is_a?(Teacher)
    end
  end

  def display_rentals(rental_list)
    rental_list.each_with_index do |rental, index|
      puts "#{index + 1} | Date: #{rental.date}, Book: #{rental.book.title}- By the author: #{rental.book.author}, Rented by: #{rental.person.name}"
    end
  end

  def list_books
    seperator
    if @books.length.zero?
      (puts 'Book list is empty')
    else
      puts 'Book list:'
      display_books
    end
    seperator
  end

  def list_people
    seperator
    if @people.length.zero?
      (puts 'People list is empty')
    else
      puts 'People list:'
      display_people
    end
    seperator
  end

  def create_student(name, age)
    puts 'Has parent permission? [Y/N]'
    permission = gets.chomp.downcase
    permission = true if permission == 'y'
    permission = false if permission == 'n'
    puts 'Classroom:'
    classroom = gets.chomp
    student = Student.new(age, classroom, name, parent_permission: permission)
    puts "Student #{student.name} has been created successfully."
  end

  def create_teacher(name, age)
    puts 'Specialization:'
    specialization = gets.chomp
    teacher = Teacher.new(age, specialization, name)
    puts "Teacher #{teacher.name} has been created successfully."
  end

  def create_person
    seperator
    option = ''
    loop do
      puts "Do you want to create a student (1) or a teacher (2)? [Input the number]\n"
      option = gets.chomp.to_i
      break if [1, 2].include?(option)
    end
    puts 'Name:'
    name = gets.chomp
    puts 'Age:'
    age = gets.chomp.to_i
    case option
    when 1
      create_student(name, age)
    when 2
      create_teacher(name, age)
    end
    seperator
  end

  def create_book
    seperator
    puts 'Title:'
    title = gets.chomp
    puts 'Author:'
    author = gets.chomp
    book = Book.new(title, author)
    puts "Book #{book.title} has been created successfully."
    seperator
  end

  def create_rental
    seperator
    if @books.length.zero?
      (puts 'The book list is empty please create a book first.')
    elsif @people.length.zero?
      (puts 'The people list is empty please add a person first.')
    else
      puts 'Select a book from the following list by number:'
      display_books
      book = @books[gets.chomp.to_i - 1]
      puts 'Select a person from the following list by number:'
      display_people
      person = @people[gets.chomp.to_i - 1]
      puts 'Date:'
      date = gets.chomp
      rental = Rental.new(date, book, person)
      puts rental.person.id
      puts('Rental created successfully.')
    end
    seperator
  end

  def list_rentals
    seperator
    if @rentals.length.zero?
      (puts 'No rentals found.')
    else
      puts 'Select an ID from the following list:'
      display_people
      id = gets.chomp.to_i
      rental_list = @rentals.select { |rental| rental.person.id == id }
      if rental_list.length.zero?
        (puts 'No rentals found for this person.')
      else
        puts 'Rental list:'
        display_rentals rental_list
      end
    end
    seperator
  end

  def seperator
    puts '*' * 70
  end

  def store_data
    puts 'Saving...'
    Book.store_books
    Student.store_students
    Teacher.store_teachers
    Rental.store_rentals
    puts 'Done!'
  end
end
