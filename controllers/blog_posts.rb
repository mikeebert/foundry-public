class Foundry < Sinatra::Application
  get "/blogpost/new/:id/:week" do
    check_for_form_errors
    @post = Repository.for(:blogpost).new
    @week = params[:week].to_i
    erb '/blogpost/new'.to_sym
  end

  post "/blogpost" do
    @post = Repository.for(:blogpost).new(params)

    if @post.valid?
      Repository.for(:blogpost).save(@post)
      redirect "/apprenticeships/#{params[:apprenticeship_id]}/weeks/#{params[:week]}"
    else
      @errors = @post.errors.values.map{|error| error.to_s}
      set_apprenticeship(@post.apprenticeship_id)
      @week = @post.week
      erb '/blogpost/new'.to_sym
    end
  end

end
