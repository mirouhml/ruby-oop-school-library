require_relative './base_decorator'

class TrimmerDecorator < BaseDecorator
  def initialize(nameable)
    super
  end
  
  def correct_name
    name = @nameable.correct_name
    name.length > 10 ? name[0..9] : name
  end
end