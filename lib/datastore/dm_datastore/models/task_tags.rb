require 'data_mapper'

class TaskTags
  include DataMapper::Resource

  property :id,         Serial
  property :created_at, DateTime

  belongs_to :task, :key => true
  belongs_to :tag, :key => true
end
