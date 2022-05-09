require_relative './student'
require_relative './teacher'

person = Student.new(17, 'A', 'Ammar', parent_permission: false)

puts(person.can_use_services?)
puts(person.name)
puts(person.name = ('Mirou'))
puts(person.name)
puts(person.age = (18))
puts(person.can_use_services?)
puts(person.play_hooky)

teacher = Teacher.new(32, 'A', 'Ammar')
puts(teacher.can_use_services?)
