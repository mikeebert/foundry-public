require 'bcrypt'
require 'datastore/memory_datastore/models/base'

module Memory
  class User < Base
    attr_accessor :admin, :id, :name, :email, :password

    def initialize(params = {})
      validate_presence_of(params, :name, :email)
      @name = params[:name]
      @email = params[:email]
      encrypt_password(params[:password]) if params.include?(:password) || params.include?("password")
      @admin = true if params[:admin] == true
    end

    def encrypt_password(password, encryption_level = 2)
      @password = BCrypt::Password.create(password, :cost => encryption_level)
    end
    
    def admin?
      @admin == true
    end
    
    def password=(password)
      encrypt_password(password, 2)
    end

    def authenticate(password)
      @password == password
    end

    def apprenticeships
      Repository.for(:apprenticeship).user_apprenticeships(@id)
    end

  end
end
