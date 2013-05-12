require 'datastore/dm_datastore/base_repository'
require 'datastore/dm_datastore/models/task'

module DmDatastore
  class Task < BaseRepository

    def model_class
      ::Task
    end

    def all
      model_class.all
    end

    def reset
      model_class.destroy
    end

    def delete(object)
      object.destroy
    end

    def apprenticeship_week(id, week)
      model_class.all(:apprenticeship_id => id, :week => week)
    end

    def all_weekly_tasks_for(id)
      model_class.all(:apprenticeship_id => id)
    end

    def general_tasks_for_apprentice(id)
      model_class.all(:apprenticeship_id => id, :week => 0)
    end

  end
end
