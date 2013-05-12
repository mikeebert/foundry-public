require 'datastore/dm_datastore/base_repository'

module DmDatastore
  class Apprenticeship < BaseRepository
    
    def model_class
      ::Apprenticeship
    end

    def new(attributes = {})
      model_class.new(attributes)
    end

    def all
      model_class.all
    end

    def reset
      model_class.destroy
    end

    def user_apprenticeships(n)
      all.select do |apprenticeship|
        apprenticeship.apprentice_id == n || apprenticeship.mentor_id == n
      end
    end

  end
end
