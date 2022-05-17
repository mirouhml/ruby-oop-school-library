require_relative './person'
require_relative './classroom'

class Student < Person
  attr_reader :classroom

  def initialize(age, classroom = 'Default', name = 'unknown', id = Random.rand(1..10_000), parent_permission: true)
    super age, name, id
    @parent_permission = parent_permission
    @classroom = Classroom.new(classroom)
    check = -> { @classroom.students.push(self) unless @classroom.students.include?(self) }
    check.call
  end

  def classroom=(classroom)
    @classroom = Classroom.new(classroom)
    check.call
  end

  def of_age?
    return true if @age > 17

    false
  end

  def can_use_services?
    return true if @parent_permission || of_age?

    false
  end

  def self.store_students
    students = {}
    @@people.each_with_index do |p, index|
      if p.is_a?(Student)
        students[index] =
          { id: p.id, name: p.name, age: p.age, parent_permission: p.parent_permission, classroom: p.classroom.label }
      end
    end
    students = students.to_json
    File.write('data/students.json', students)
    students
  end

  def self.restore_students
    return unless File.exist?('data/students.json') && !File.zero?('data/students.json')

    file = File.open('data/students.json', 'r')
    file_json = JSON.parse(file.read)
    file_json.each_key do |key|
      new(file_json[key]['age'], file_json[key]['classroom'], file_json[key]['name'], file_json[key]['id'],
          parent_permission: file_json[key]['parent_permission'])
    end
  end

  private :of_age?
end
