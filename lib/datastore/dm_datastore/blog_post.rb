require 'datastore/dm_datastore/base_repository'

module DmDatastore
  class Blogpost < BaseRepository

    def model_class
      ::Blogpost
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

    def destroy_all
      model_class.all.destroy
    end
  end
end
