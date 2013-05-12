require 'datastore/memory_datastore/base_repository'

module MemoryDatastore
  class Apprenticeship < BaseRepository

    def model_class
      Memory::Apprenticeship
    end

    def all
      @records.values
    end
    
    def user_apprenticeships(n)
      @records.values.select do |apprenticeship| 
        apprenticeship.apprentice_id == n || apprenticeship.mentor_id == n
      end
    end
    
    def reset
      @records = Hash.new
      @id = 1
    end
  end
end
