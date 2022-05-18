require_relative '../trimmer_decorator'

describe TrimmerDecorator do
  context 'When testing the CapitalizeDecorator class' do
    it 'should say \'maximilian\' when we call the correct_name method' do
      person = Person.new(24, 'maximilianus')
      trimmer_decorator = TrimmerDecorator.new(person)
      name = trimmer_decorator.correct_name
      expect(name).to eq 'maximilian'
    end
  end
end
