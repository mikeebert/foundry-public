require 'datastore/memory_datastore/base_repository'

module MemoryDatastore
  class Feedback < BaseRepository

    def model_class
      Memory::Feedback
    end
    
    def feedback_for_apprenticeship_and_week(apprenticeship_id, week)
      @records.values.select {|feedback| feedback.apprenticeship_id == apprenticeship_id && feedback.week == week}
    end

    def reset
      @records = {}
      @id = 1
    end
  end
end
