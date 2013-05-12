require 'pry'

module DmDatastore
  class BaseRepository

    def new(attributes = {})
      model_class.new(attributes)
    end

    def save(model)
      model.save
      return model
    end

    def find_by_id(n)
      model_class.get(n)
    end

    def all
      model_class.all
    end
  end
end
