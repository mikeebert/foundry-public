configure do
  $: << File.expand_path(File.dirname(__FILE__)) + '/lib'
  $: << File.expand_path(File.dirname(__FILE__)) + '/lib/datastore'

  Dir[File.dirname(__FILE__) + '/controllers/*.rb'].each {|file| require file }
  Dir[File.dirname(__FILE__) + '/lib/datastore/dm_datastore/*.rb'].each {|file| require file }

  require 'data_mapper'
  require 'repository'
end

configure :production do
  #DataMapper models
  DataMapper.setup(:default, ENV['DATABASE_URL'])
  require 'dm_datastore/models/user'
  require 'dm_datastore/models/apprenticeship'
  require 'dm_datastore/models/task'
  require 'dm_datastore/models/feedback'
  require 'dm_datastore/models/blog_post'
  DataMapper.finalize.auto_upgrade!  

  {:user => DmDatastore::User.new,
   :apprenticeship => DmDatastore::Apprenticeship.new,
   :task => DmDatastore::Task.new, 
   :feedback => DmDatastore::Feedback.new,
   :blogpost => DmDatastore::Blogpost.new
  }.each do |type, repo|
    Repository.register(type, repo)
  end
end

configure :development do
  require './config/seeds'

  #DataMapper models
  DataMapper.setup(:default, 'postgres://localhost/foundry')
  require 'dm_datastore/models/user'
  require 'dm_datastore/models/apprenticeship'
  require 'dm_datastore/models/task'
  require 'dm_datastore/models/feedback'
  require 'dm_datastore/models/blog_post'
  DataMapper.finalize.auto_upgrade!  

  {:user => DmDatastore::User.new,
   :apprenticeship => DmDatastore::Apprenticeship.new,
   :task => DmDatastore::Task.new, 
   :feedback => DmDatastore::Feedback.new,
   :blogpost => DmDatastore::Blogpost.new
  }.each do |type, repo|
    Repository.register(type, repo)
  end

  DmDatastore::Seed.users
  DmDatastore::Seed.apprenticeships
end

configure :test do
  DataMapper.setup(:default, 'postgres://localhost/foundry_test')

  DataMapper.finalize.auto_upgrade!  
end
