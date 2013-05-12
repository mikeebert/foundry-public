class Foundry < Sinatra::Application
  get "/apprenticeships/:id/weeks/:week/feedback/new" do
    @feedback = Repository.for(:feedback).new
    @week = params[:week].to_i
    erb '/feedback/new'.to_sym
  end

  get "/apprenticeships/:id/weeks/:week/feedback" do
    @week = params[:week].to_i
    @feedback = Repository.for(:feedback).find_by_id(params[:id].to_i)
    erb '/feedback/show'.to_sym
  end
  
  post "/feedback" do
    @feedback = Repository.for(:feedback).new(params)

    if @feedback.valid?
      Repository.for(:feedback).save(@feedback)
      redirect "/apprenticeships/#{@feedback.apprenticeship_id}/weeks/#{@feedback.week}"
    else
      @errors = @feedback.errors.values.map{|error| error.to_s}
      set_apprenticeship(@feedback.apprenticeship_id)
      @week = @feedback.week
      erb '/feedback/new'.to_sym
    end
  end
end
