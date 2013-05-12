class Foundry < Sinatra::Application
  get "/users" do
    check_for_admin
    @users = Repository.for(:user).all
    erb '/users/index'.to_sym
  end

  get "/users/new" do
    #@user = Repository.for(:user).new
    #erb '/users/new'.to_sym
    erb '/login'.to_sym
  end

  post "/users" do
    @user = Repository.for(:user).save(Repository.for(:user).new(params))

    if @user.valid?
      erb '/users/thankyou'.to_sym
    else
      flash[:error] = "There was an error creating your account. That email is probably taken."
      erb '/users/new'.to_sym
    end
  end

  get "/users/:id" do
    check_authentication #would like to move into before filter group but catches /users/new
    if current_user.admin?
      @user = Repository.for(:user).find_by_id(params[:id])
    else
      @user = current_user
    end
    erb '/users/show'.to_sym
  end
end

