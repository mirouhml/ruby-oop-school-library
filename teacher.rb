require_relative './person'

class Teacher < Person
  attr_reader :specialization
  
  def initialize(age, specialization, name = 'unknown', parent_permission: true)
    super age, name, parent_permission: parent_permission
    @specialization = specialization
  end

  def can_use_services?
    true
  end

  def self.store_teachers
    teachers = {}
    @@people.each_with_index do |p, index|
      teachers[index] = { :name => p.name, :age => p.age, :specialization => p.specialization } if p.is_a?(Teacher)
    end
    teachers = teachers.to_json
    File.open("data/teachers.json","w") do |f|
      f.write(teachers)
    end
    teachers
  end

  def self.restore_teachers
    if File.exist?("data/teachers.json") 
      file = File.open('data/teachers.json','r')
      file_json = JSON.parse(file.read)
      file_json.each_key { |key| new(file_json[key]['age'], file_json[key]['specialization'], file_json[key]['name'], parent_permission: true) }
    end
  end
end
