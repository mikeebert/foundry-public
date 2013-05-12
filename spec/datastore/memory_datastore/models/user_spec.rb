require 'spec_helper'
require 'datastore/memory_datastore/models/user'
require 'datastore/shared_examples/models/user_examples'

module Memory
  describe User do

    before(:all) do
      @user = User.new(:name => "Mike", :email => "test@test.com")
    end

    it_behaves_like "user model"

  end
end
