class Foundry < Sinatra::Application
  get "/apprenticeships/checklist" do
    erb '/apprenticeships/checklist'.to_sym
  end

  get "/apprenticeships" do
    check_for_admin
    @apprenticeships = Repository.for(:apprenticeship).all
    erb '/apprenticeships/index'.to_sym
  end

  get "/apprenticeships/new" do
    @users = Repository.for(:user).all
    erb "/apprenticeships/new".to_sym
  end
  
  post "/apprenticeships" do
    params[:start_date] = DateHelper.format(params[:start_date])
    params[:end_date] = DateHelper.format(params[:end_date])
    @apprenticeship = Repository.for(:apprenticeship).save(Repository.for(:apprenticeship).new(params))
    erb '/apprenticeships/confirmation'.to_sym
  end
  
  get "/apprenticeships/:id" do
    @general_tasks = @apprenticeship.all_general_tasks.sort! { |a,b| a.week <=> b.week}
    erb '/apprenticeships/show'.to_sym
  end
  
  get "/apprenticeships/:id/weeks/:week" do
    @week = params[:week].to_i
    @tasks = @apprenticeship.tasks_for_week(@week)
    erb '/apprenticeships/week'.to_sym
  end
  
  get "/week" do
    redirect "/apprenticeships/#{params[:apprenticeship_id]}/weeks/#{params[:week_number]}"
  end
end
