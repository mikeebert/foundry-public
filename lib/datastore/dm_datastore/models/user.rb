require 'data_mapper'
require 'bcrypt'

class User
  include DataMapper::Resource

  property :id,         Serial
  property :admin,      Boolean, :default => false
  property :name,       String, :required => true
  property :email,      String, :required => true, :unique => true
  property :password,   BCryptHash
  property :created_at, DateTime
  property :updated_at, DateTime

  def authenticate(password)
    @password == password
  end

  def apprenticeships
    Repository.for(:apprenticeship).user_apprenticeships(@id)
  end
  
end
