require_relative '../base_decorator'

describe BaseDecorator do
  context 'When testing the BaseDecorator class' do
    it 'should say \'ammar\' when we call the correct_name method' do
      person = Person.new(24, 'ammar')
      base_decorator = BaseDecorator.new(person)
      name = base_decorator.correct_name
      expect(name).to eq 'ammar'
    end
  end
end
