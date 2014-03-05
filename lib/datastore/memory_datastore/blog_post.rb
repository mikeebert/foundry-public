require 'datastore/memory_datastore/base_repository'

module MemoryDatastore
  class Blogpost < BaseRepository

    def model_class
      Memory::Blogpost
    end

    def posts_for_apprenticeship_and_week(apprenticeship_id, week)
      @records.values.select {|post| post.apprenticeship_id == apprenticeship_id && post.week == week}
    end

    def destroy_all
      @records = {}
    end
  end
end
