require_relative '../capitalize_decorator'

describe CapitalizeDecorator do 
  context 'When testing the CapitalizeDecorator class' do 
    it 'should say \'Ammar\' when we call the correct_name method' do 
      person = Person.new(24, 'ammar')
      capitalize_decorator = CapitalizeDecorator.new(person)
      name = capitalize_decorator.correct_name
      expect(name).to eq 'Ammar'
    end
  end
end
