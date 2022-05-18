require_relative '../student'

describe Student do
  context 'When testing the Student class' do
    age = '19'
    name = 'Mark'
    classroom = 'Science'
    student = Student.new(age, classroom, name)

    it 'should validate the age of the student' do
      expect(student.age).to eq age
    end

    it 'should validate the name of the student' do
      expect(student.name).to eq name
    end

    it 'should return the classroom of the student' do
      expect(student.classroom.label).to eq classroom
    end

    it 'should return true when we call the can_use_services? method' do
      expect(student.can_use_services?).to eq true
    end

    it 'should return true when we call the can_use_services? method for a student who\'s age is greater than 18 and doesn\'t have his parent\'s permission' do
      new_student = Student.new(18, classroom, name, parent_permission: false)
      expect(new_student.can_use_services?).to eq true
    end

    it 'should return false when we call the can_use_services? method for a student who\'s age is less than 18 and doesn\'t have his parent\'s permission' do
      new_student = Student.new(17, classroom, name, parent_permission: false)
      expect(new_student.can_use_services?).to eq false
    end

    it 'should return true when we call the can_use_services? method for a student who\'s age is less than 18 and has their parent\'s permission' do
      new_student = Student.new(17, classroom, name, parent_permission: true)
      expect(new_student.can_use_services?).to eq true
    end
  end
end
