require 'date'

class MockApprenticeship
  attr_accessor :id,
                :apprentice_id,
                :mentor_id,
                :start_date,
                :end_date
                
  def initialize
    @start_date = Date.today
    @end_date = Date.today
  end

  def apprentice
    FakeUser.new
  end
  
  def mentor
    FakeUser.new
  end
  
  def weeks
    {1 => Date.today}
  end
  
  def tasks_for_week(n)
    []
  end
  
  def all_general_tasks
    []
  end
  
  def feedback_for_week(n)
    []
  end
  
  def weeks_starting_in_last_ten_days
    []
  end

  def posts_for_week(n)
    []
  end
end

class FakeUser
  attr_accessor :name, :id
end
