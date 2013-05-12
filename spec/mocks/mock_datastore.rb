class MockDatastore
  attr_accessor :asked_to_reset,
                :id_of_search_executed,
                :returned_tasks_for,
                :received_all_weekly_task_request,
                :received_request_for_all_general_tasks,
                :stores, 
                :users
  
  def initialize(*objects)
    @stores = []
    objects.each do |ob|
      @stores << ob
    end
  end
  
  def find_by_id(n)
    @id_of_search_executed = n
    @stores.shift
  end

  def get(n)
    @id_of_search_executed = n
  end

  def apprenticeship_week(apprenticeship_id, week_integer)
    @returned_tasks_for = [apprenticeship_id, week_integer]
  end
  
  def reset
    @asked_to_reset = true
  end

  def all_weekly_tasks_for(n)
    @received_all_weekly_task_request = true
  end

  def general_tasks_for_apprentice(n)
    @received_request_for_all_general_tasks = true
  end  
  
  
end
