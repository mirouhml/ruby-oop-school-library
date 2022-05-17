require_relative './person'
require_relative './classroom'

class Student < Person
  attr_reader :classroom

  def initialize(age, classroom = 'Default', name = 'unknown', parent_permission: true)
    super age, name, parent_permission: parent_permission
    @classroom = Classroom.new(classroom)
    check = -> { @classroom.students.push(self) unless @classroom.students.include?(self) }
    check.call
  end

  def classroom=(classroom)
    @classroom = Classroom.new(classroom)
    check.call
  end

  def self.store_students
    students = {}
    @@people.each_with_index do |p, index|
      students[index] = { :name => p.name, :age => p.age, :parent_permission => p.parent_permission, :classroom => p.classroom.label } if p.is_a?(Student)
    end
    students = students.to_json
    File.open("data/students.json","w") do |f|
      f.write(students)
    end
    students
  end

  def self.restore_students
    if File.exist?("data/students.json") 
      file = File.open('data/students.json','r')
      file_json = JSON.parse(file.read)
      file_json.each_key { |key| new(file_json[key]['age'], file_json[key]['classroom'], file_json[key]['name'], parent_permission: file_json[key]['parent_permission']) }
    end
  end
end
