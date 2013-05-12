require 'datastore/dm_datastore/models/user'
require 'datastore/dm_datastore/models/apprenticeship'
require 'repository'
require 'date'

module DmDatastore
  class Seed
    def self.users
      Repository.for(:user).reset

      @jim = ::User.create(name: "Jim", email: "jim@test", password: "password")
      @roger = ::User.create(name: "Roger", email: "roger@test", password: "password")
      @joe = ::User.create(name: "Joe", email: "joe@test", password: "password")
      @phil = ::User.create(name: "Phil", email: "phil@test", password: "password")
      @ed = ::User.create(name: "Ed", email: "ed@test", password: "password")
      @admin = ::User.create(name: "Admin", email: "admin@admin", password: "test", admin: true)

      [@jim, @roger, @joe, @phil, @ed, @admin].each do |user|
        Repository.for(:user).save(user)
      end
    end

    def self.apprenticeships
      Repository.for(:apprenticeship).reset
      [::Apprenticeship.create(apprentice_id: @jim.id, 
                           mentor_id: @roger.id, 
                           start_date: (Date.today - 90),
                           end_date: (Date.today + 30)),
       ::Apprenticeship.create(apprentice_id: @joe.id, 
                           mentor_id: @phil.id, 
                           start_date: (Date.today - 10), 
                           end_date: (Date.today + 180)),
       ::Apprenticeship.create(apprentice_id: @ed.id, 
                           mentor_id: @phil.id, 
                           start_date: (Date.today - 180), 
                           end_date: (Date.today - 30))
      ].each do |apprenticeship|
        Repository.for(:apprenticeship).save(apprenticeship)
      end
    end

  end
end
