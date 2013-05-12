require 'datastore/memory_datastore/base_repository'

module MemoryDatastore
  class Task < BaseRepository

    def model_class
      Memory::Task
    end

    def all
      @records.values
    end

    def delete(task)
      @records.delete(task.id)
    end
    
    def apprenticeship_week(id, week)
      weekly_tasks = []
      @records.values.each do |task|
        if task.apprenticeship_id == id && task.week == week
          weekly_tasks << task
        end
      end
      return weekly_tasks
    end

    def all_weekly_tasks_for(apprenticeship_id)
      @records.values.select {|task| task.apprenticeship_id == apprenticeship_id}
    end
    
    def general_tasks_for_apprentice(apprenticeship_id)
      @records.values.select do |task| 
        task.week == 0 && task.apprenticeship_id == apprenticeship_id
      end
    end

    def reset
      @records = Hash.new
      @id = 1
    end

  end
end
