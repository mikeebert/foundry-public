require 'datastore/dm_datastore/base_repository'

module DmDatastore
  class Blogpost < BaseRepository

    def model_class
      ::Blogpost
    end

  end
end
