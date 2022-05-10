require_relative './person'
require_relative './student'
require_relative './book'
require_relative './teacher'
require_relative './rental'

class App
  def initialize
    @books = Book.class_variable_get(:@@books)
    @people = Person.class_variable_get(:@@people)
    @rentals = Rental.class_variable_get(:@@rentals)
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
      break if user_input >= 7

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

  def list_books
    puts '*' * 70
    if @books.length.zero?
      (puts 'Book list is empty')
    else
      puts 'Book list:'
      @books.each_with_index do |book, index|
        puts "#{index + 1} | #{book.title} - By #{book.author}"
      end
    end
    puts '*' * 70
  end

  def list_people
    puts '*' * 70
    if @people.length.zero?
      (puts 'People list is empty')
    else
      puts 'People list:'
      @people.each_with_index do |person, index|
        puts "[Student] #{index + 1} | Name: #{person.name} - Age: #{person.age}" if person.is_a?(Student)
        puts "[Teacher] #{index + 1} | Name: #{person.name} - Age: #{person.age}" if person.is_a?(Teacher)
      end
    end
    puts '*' * 70
  end

  def create_person
    puts '*' * 70
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
      puts 'Has parent permission? [Y/N]'
      permission = gets.chomp.downcase
      permission = true if permission == 'y'
      permission = false if permission == 'n'
      puts 'Classroom:'
      classroom = gets.chomp
      student = Student.new(age, classroom, name, parent_permission: permission)
      puts "Student #{student.name} has been created successfully."
    when 2
      puts 'Specialization:'
      specialization = gets.chomp
      teacher = Teacher.new(age, specialization, name)
      puts "Teacher #{teacher.name} has been created successfully."
    end
    puts '*' * 70
  end

  def create_book
    puts '*' * 70
    puts 'Title:'
    title = gets.chomp
    puts 'Author:'
    author = gets.chomp
    book = Book.new(title, author)
    puts "Book #{book.title} has been created successfully."
    puts '*' * 70
  end

  def create_rental
    puts '*' * 70
    if @books.length.zero?
      (puts 'The book list is empty please create a book first.')
    elsif @people.length.zero?
      (puts 'The people list is empty please add a person first.')
    else
      puts 'Select a book from the following list by number:'
      @books.each_with_index do |b, index|
        puts "#{index + 1} | #{b.title} - By #{b.author}"
      end
      book = @books[gets.chomp.to_i - 1]
      puts 'Select a person from the following list by number:'
      @people.each_with_index do |p, index|
        puts "#{index + 1} | Name: #{p.name} - Age: #{p.age}" if p.is_a?(Student)
        puts "#{index + 1} | Name: #{p.name} - Age: #{p.age}" if p.is_a?(Teacher)
      end
      person = @people[gets.chomp.to_i - 1]
      puts 'Date:'
      date = gets.chomp
      Rental.new(date, book, person)
      puts('Rental created successfully.')
    end
    puts '*' * 70
  end

  def list_rentals
    puts '*' * 70
    if @rentals.length.zero?
      (puts 'No rentals found.')
    else
      puts 'Select a person from the following list by number:'
      @people.each_with_index do |person, index|
        puts "#{index + 1} | Name: #{person.name} - Age: #{person.age}"
      end
      person = @people[gets.chomp.to_i - 1]
      rental_list = @rentals.select { |rental| rental.person.id == person.id }
      if rental_list.length.zero?
        (puts 'No rentals found for this person.')
      else
        puts 'Rental list:'
        rental_list.each_with_index do |rental, index|
          puts "#{index + 1} | Date: #{rental.date}, Book: #{rental.book.title}- By the author: #{rental.book.author}, Rented by: #{rental.person.name}"
        end
      end
    end
    puts '*' * 70
  end
end

def main
  app = App.new
  app.run
end

main
