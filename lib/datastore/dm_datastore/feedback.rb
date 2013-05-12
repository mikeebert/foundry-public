require 'datastore/dm_datastore/base_repository'

module DmDatastore
  class Feedback < BaseRepository

    def model_class
      ::Feedback
    end

  end
end
