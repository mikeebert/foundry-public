# original action
# some tension because I'm calling .new on the Repository.for(:blogpost)
# doesn't account for any errors in saving

  post "/blogpost" do
    Repository.for(:blogpost).save(Repository.for(:blogpost).new(params))
    redirect "/apprenticeships/#{params[:apprenticeship_id]}/weeks/#{params[:week]}"
  end


# optional action. Much heavier but separates up responsiblities
# valid? call is directly on object. Checks if there are any errors.
  
  post "/blogpost" do
    @post = Repository.for(:blogpost).new(params)

    if @post.valid?
      Repository.for(:blogpost).save(@post)
      session.delete(:errors)
      redirect "/apprenticeships/#{@post.apprenticeship_id}/weeks/#{@post.week}"
    else
      session[:errors] = @post.errors.values.map{|error| error.to_s}
      redirect "/blogpost/new/#{@post.apprenticeship_id}/#{@post.week}"
    end
  end

  def clear_errors
    session.delete(:errors)
  end

  #
  post "/blogpost" do
    @post = Repository.for(:blogpost).new(params)
    PostValidations.check_for_errors(@post, session[:errors])

    if session[:errors].nil?
      Repository.for(:blogpost).save(@post)
      redirect "/apprenticeships/#{@post.apprenticeship_id}/weeks/#{@post.week}"
    else
      redirect "/blogpost/new/#{@post.apprenticeship_id}/#{@post.week}"
    end
  end

