require 'datastore/dm_datastore/base_repository'

module DmDatastore
  class User < BaseRepository

    def model_class
      ::User
    end

    def find_by_email(email)
      user = model_class.first(:email => email)
      return user
    end

    def all
      model_class.all
    end

    def reset
      model_class.destroy
    end
  end
end
