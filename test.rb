require 'json'
require_relative './book'

book = Book.new('Book1', 'Author1')
puts book.class
books = Book.class_variable_get(:@@books)
puts books[0].class
