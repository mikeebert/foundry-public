require 'datastore/memory_datastore/base_repository'

module MemoryDatastore
  class User < BaseRepository
    
    def model_class
      Memory::User
    end
    
    def find_by_email(email)
      @records.values.select {|user| user.email == email}.shift
    end

    def all
      @records.values
    end

    def reset
      @records = Hash.new
      @id = 1
    end
  end
end
