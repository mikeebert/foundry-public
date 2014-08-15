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

  delete "/blogpost/:id" do
    post = Repository.for(:blogpost).find_by_id(params[:id])
    Repository.for(:blogpost).delete(post)

    if params[:week].to_i == 0
      redirect "/apprenticeships/#{params[:apprenticeship_id]}"
    else
      redirect "/apprenticeships/#{params[:apprenticeship_id]}/weeks/#{params[:week]}"
    end
  end
end
