require_relative '../classroom'

describe Classroom do
  context 'When testing the Classroom class' do
    classroom_label = 'Math'
    classroom = Classroom.new('Math')

    it 'should validate the classroom label' do
      expect(classroom_label).to eq classroom.label
    end
  end
end
