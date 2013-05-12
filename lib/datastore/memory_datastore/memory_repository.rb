require 'datastore/memory_datastore/memory_repo_factory'

module MemoryDatastore
  class MemoryRepository
    attr_accessor :store

    def initialize(classes = [])
      @store = Hash.new
      @datastore_factory = MemoryDatastore::MemoryRepoFactory.new
      add_datastores(classes)
    end

    def add_datastores(classes)
      classes.each do |klass| 
        @store[klass] = @datastore_factory.create(klass)
      end
    end

    def for(klass)
      return @store[klass.to_sym]
    end
    
    def clear_all
      @store.values.each do |klass|
        klass.reset
      end
    end
  end
end
