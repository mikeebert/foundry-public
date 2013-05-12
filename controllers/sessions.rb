class Foundry < Sinatra::Application
# User Access Control
  get "/login" do
    erb '/login'.to_sym
  end

  post "/session" do
    warden_handler.authenticate!
    if warden_handler.authenticated?
      redirect "/users/#{warden_handler.user.id}" 
    else
      erb '/login'.to_sym
    end
  end

  get "/logout" do
    warden_handler.logout
    redirect '/login'
  end

  get "/unauthorized" do
    erb '/unauthorized'.to_sym
  end 

  post "/unauthenticated" do
    flash[:error] = "Login failed. Please try again."
    redirect "/login"
  end

# Warden Authentication Info
  use Rack::Session::Cookie

  use Warden::Manager do |manager|
    manager.default_strategies :password
    manager.failure_app = Foundry
    manager.serialize_into_session {|user| user.id}
    manager.serialize_from_session {|id| Repository.for(:user).find_by_id(id)}
  end

  Warden::Manager.before_failure do |env,opts|
    env['REQUEST_METHOD'] = 'POST'
  end

  Warden::Strategies.add(:password) do
    def valid?
      params["email"] || params["password"]
    end

    def authenticate!
      user = Repository.for(:user).find_by_email(params["email"])
      if user && user.authenticate(params["password"])
        success!(user)
      else
        fail!("Could not log in")
      end
    end
  end

  def warden_handler
    env['warden']
  end

  def check_authentication
    unless warden_handler.authenticated?
      redirect '/login'
    end
  end

  def check_user_access(apprenticeship)
    unless current_user.id == apprenticeship.apprentice_id || current_user.id == apprenticeship.mentor_id
      redirect "/unauthorized"
    end
  end

  def current_user
    warden_handler.user
  end
  
  def check_for_admin
    unless warden_handler.authenticated? && current_user.admin?
      redirect '/unauthorized'
    end
  end
end
