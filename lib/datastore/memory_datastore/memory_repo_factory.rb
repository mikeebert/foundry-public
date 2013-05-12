require 'datastore/memory_datastore/user'
require 'datastore/memory_datastore/apprenticeship'
require 'datastore/memory_datastore/task'
require 'datastore/memory_datastore/feedback'
require 'datastore/memory_datastore/blog_post'

module MemoryDatastore
  class MemoryRepoFactory
    def create(type)
      if type == :user
        return User.new
      elsif type == :apprenticeship
        return Apprenticeship.new
      elsif type == :task
        return Task.new
      elsif type == :feedback
        return Feedback.new
      elsif type == :blogpost
        return Blogpost.new
      else
        return Hash.new
      end
    end
  end
end
