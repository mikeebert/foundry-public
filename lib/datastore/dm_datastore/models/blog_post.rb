require 'data_mapper'

class Blogpost
  include DataMapper::Resource

  property :id,           Serial
  property :week,         Integer, :required => true
  property :title,        Text, :required => true
  property :url,          Text, :required => true
  property :created_at,   DateTime
  property :updated_at,   DateTime

  belongs_to :apprenticeship

  before(:save) do
    set_url
  end

  def set_url
    unless self.url.include?("http://")
      self.url = "http://" + self.url
    end
  end

end
