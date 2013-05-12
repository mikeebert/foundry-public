class Foundry < Sinatra::Application
  get "/apprenticeships/:id/weeks/:week/tasks/new" do
    @task = Repository.for(:task).new
    @week = params[:week].to_i
    @tags = Tags::CATEGORIES
    erb '/tasks/new'.to_sym
  end
  
  get "/apprenticeships/:id/weeks/:week/tasks/:task" do
    @task = Repository.for(:task).find_by_id(params[:task])
    @tags = Tags::CATEGORIES
    erb '/tasks/show'.to_sym
  end
  
  get "/apprenticeships/:id/tasks/:task_id/edit" do
    @task = Repository.for(:task).find_by_id(params[:task_id])
    @week = @task.week
    @tags = Tags::CATEGORIES
    erb '/tasks/edit'.to_sym
  end

  post "/tasks" do
    sanitized_params = sanitize_task_params(params)
    @task = Repository.for(:task).new(sanitized_params)

    if @task.valid?
      Repository.for(:task).save(@task)
      if @task.general
        redirect "/apprenticeships/#{params[:apprenticeship_id]}"
      else
        redirect "/apprenticeships/#{params[:apprenticeship_id]}/weeks/#{params[:week]}"
      end
    else
      @errors = @task.errors.values.map{|error| error.to_s}
      set_apprenticeship(@task.apprenticeship_id)
      @week = @task.week
      @tags = Tags::CATEGORIES
      erb '/tasks/new'.to_sym
    end
  end
  
  put "/tasks/:id" do
    @task = Repository.for(:task).find_by_id(params[:id])
    sanitized_params = sanitize_task_params(params)
    @task.update(sanitized_params)

    if @task.valid?
      if @task.general
        redirect "/apprenticeships/#{params[:apprenticeship_id]}"
      else
        redirect "/apprenticeships/#{params[:apprenticeship_id]}/weeks/#{params[:week]}"
      end
    else
      @errors = @task.errors.values.map{|error| error.to_s}
      set_apprenticeship(@task.apprenticeship_id)
      @week = @task.week
      @tags = Tags::CATEGORIES
      erb '/tasks/edit'.to_sym
    end

  end
  
  delete "/tasks/:id" do
    task = Repository.for(:task).find_by_id(params[:id])
    Repository.for(:task).delete(task)
    
    if params[:week].to_i == 0
      redirect "/apprenticeships/#{params[:apprenticeship_id]}"
    else
      redirect "/apprenticeships/#{params[:apprenticeship_id]}/weeks/#{params[:week]}"
    end
  end

  post "/general_tasks" do
    Repository.for(:task).save(Task.new(params))
    redirect "/apprenticeships/#{params[:apprenticeship_id]}"
  end
end
