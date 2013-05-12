module MemoryDatastore
  class BaseRepository
    attr_accessor :records, :id

    def initialize
      @records = {}
      @id = 1
    end

    def new(attributes = {})
      model_class.new(attributes)
    end

    def save(object)
      object.id = @id
      @records[@id] = object
      @id += 1
      return object
    end

    def find_by_id(n)
      @records[n.to_i]
    end

    def all
      @records.values
    end
  end
end
