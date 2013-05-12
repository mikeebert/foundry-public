require 'data_mapper'

class Feedback
  include DataMapper::Resource

  property :id,         Serial
  property :week,       Integer, :required => true
  property :rating,     Integer, :required => true
  property :good,       Text, :required => true
  property :improve,    Text, :required => true
  property :change,     Text, :required => true
  property :created_at, DateTime
  property :updated_at, DateTime

  belongs_to :apprenticeship
  belongs_to :author, 'User', :child_key => [:author_id]

end
