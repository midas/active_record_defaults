class Person < ActiveRecord::Base
  defaults :city => 'Christchurch', :country => Proc.new { 'New Zealand' }
  
  default :first_name => 'Sean'
  
  default :last_name do
    'Fitzpatrick'
  end
  
  defaults :lucky_number => lambda { 2 }
  
  def defaults
    self.birthdate = Date.new(2006, 10, lucky_number) if lucky_number?
  end
  
  belongs_to :school
end

class PersonWithDefaultSchool < Person
  default :school do
    School.find(1)
  end
end

class PersonWithDefaultSchoolId < Person
  default :school_id => 1
end
