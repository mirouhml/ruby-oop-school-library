require_relative './person'

class Teacher < Person
  attr_reader :specialization

  def initialize(age, specialization, name = 'unknown', id = Random.rand(1..10_000), parent_permission: true)
    super age, name, id, parent_permission: parent_permission
    @specialization = specialization
  end

  def can_use_services?
    true
  end

  def self.store_teachers
    teachers = {}
    @@people.each_with_index do |p, index|
      teachers[index] = { id: p.id, name: p.name, age: p.age, specialization: p.specialization } if p.is_a?(Teacher)
    end
    teachers = teachers.to_json
    File.write('data/teachers.json', teachers)
    teachers
  end

  def self.restore_teachers
    return unless File.exist?('data/teachers.json') && !File.zero?('data/teachers.json')

    file = File.open('data/teachers.json', 'r')
    file_json = JSON.parse(file.read)
    file_json.each_key do |key|
      new(file_json[key]['age'], file_json[key]['specialization'], file_json[key]['name'], file_json[key]['id'], parent_permission: true)
    end
  end
end
