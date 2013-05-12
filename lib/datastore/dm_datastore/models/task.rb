require 'data_mapper'
require 'tags'

class Task
  include DataMapper::Resource

  property :id,         Serial
  property :week,       Integer, :required => true, :default => 0
  property :title,      Text, :required => true
  property :note,       Text
  property :points,     Float
  property :tags,       Object
  property :complete,   Boolean, :default => false
  property :created_at, DateTime
  property :updated_at, DateTime

  belongs_to :apprenticeship
#  has n, :tags, :through => :task_tags

  def general
    @week == 0 ? true : false
  end
 
  def tags
    @tags.nil? ? [] : @tags
  end
 
  def display_tag_names
    return [] if @tags == nil
    names = []
    @tags.each do |tag|
      names << Tags::CATEGORIES[tag]
    end
    names
  end
  
  def current?
    (Date.today - self.apprenticeship.weeks[@week]) <= 10
  end

end


