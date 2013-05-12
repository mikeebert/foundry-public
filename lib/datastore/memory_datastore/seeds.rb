require 'datastore/memory_datastore/models/user'
require 'datastore/memory_datastore/models/apprenticeship'
require 'repository'
require 'date'

module Memory
  class Seed
    def self.users
      [User.new(name: "Jim", email: "jim@test", password: "password"),
       User.new(name: "Roger", email: "roger@test", password: "password"),
       User.new(name: "Joe", email: "joe@test", password: "password"),
       User.new(name: "Phil", email: "phil@test", password: "password"),
       User.new(name: "Ed", email: "ed@test", password: "password"),
       User.new(name: "Admin", email: "admin@admin", password: "test", admin: true)
      ].each do |user|
        Repository.for(:user).save(user)
      end
    end

    def self.apprenticeships
      [Apprenticeship.new(apprentice_id: 1, 
                          mentor_id: 2, 
                          start_date: Date.new(2012,3,1), 
                          end_date: Date.new(2012,8,31)),
       Apprenticeship.new(apprentice_id: 3, 
                          mentor_id: 4, 
                          start_date: Date.new(2012,5,1), 
                          end_date: Date.new(2012,7,31)),
       Apprenticeship.new(apprentice_id: 5, 
                          mentor_id: 4, 
                          start_date: Date.new(2012,6,1), 
                          end_date: Date.new(2012,9,1))
      ].each do |apprenticeship|
        Repository.for(:apprenticeship).save(apprenticeship)
      end
    end

  end
end
