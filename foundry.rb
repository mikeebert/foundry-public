$: << File.expand_path(File.dirname(__FILE__)) + '/lib/'
require 'sinatra'
require 'sinatra/flash'
require 'warden'
# require 'sinatra/reloader'

require './environment'
require 'repository'
require 'tags'
require 'helpers/date_helper'
require 'helpers/tag_helper'

enable :sessions

class Foundry < Sinatra::Application
  ['/apprenticeships/:id',
   '/apprenticeships/:id/weeks/:week',
   '/apprenticeships/:id/weeks/:week/feedback',
   '/apprenticeships/:id/weeks/:week/tasks/:task',
   '/apprenticeships/:id/tasks/:task_id/edit',
   '/apprenticeships/:id/weeks/:week/tasks/new',
   '/tasks/:id/new_general',
   '/apprenticeships/:id/weeks/:week/feedback/new',
   '/blogpost/new/:id/:week'
  ].each do |path|
    before(path) do
      check_authentication
      pass if params[:id] == "new"
      pass if params[:id] == "checklist"
      set_apprenticeship(params[:id])      
      pass if current_user.admin?
      check_user_access(@apprenticeship) unless @apprenticeship.nil?
    end
  end
  
  get "/" do
    if warden_handler.authenticated?
      @user = Repository.for(:user).find_by_id(current_user.id)
      erb '/users/show'.to_sym
    else
      erb '/login'.to_sym
    end
  end

private
  def set_apprenticeship(id)
    @apprenticeship = Repository.for(:apprenticeship).find_by_id(id)
  end

  def check_for_form_errors
    @errors = session[:errors]; session.delete(:errors)
  end

  def sanitize_task_params(params)
    params.delete("points") if params[:points] == ""
    params["tags"] = TagHelper.format_tags(params["tags"]) unless params["tags"].nil?

    new_params = params.select do 
      |k,v| ["apprenticeship_id", "week", "title", "note", "points", "tags", "complete"].include? k 
    end

    Hash[new_params.map {|k,v| [k.to_sym, v]}]
  end
end
