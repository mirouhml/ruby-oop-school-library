require_relative '../book'

describe Book do
  context 'when testing the Book class' do
    title = 'Lord of the rings'
    author = 'Tolkien'
    book = Book.new(title, author)

    it 'should validate the title of the book' do
      expect(book.title).to eq title
    end

    it 'should validate the author of the book' do
      expect(book.author).to eq author
    end
  end
end
