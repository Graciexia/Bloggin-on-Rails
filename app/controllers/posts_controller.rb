class PostsController < ApplicationController
  def index
    all_posts = Post.all
     respond_to do |format|
      format.html do
        render 'index.html.erb', locals: { posts: all_posts }
      end
      format.json do
        render json: all_posts
      end
    end
  end

  def show
    begin
      found_post = Post.find(params[:id])
      respond_to do |format|
        format.html do
          render 'show.html.erb', locals: { post: found_post }
        end
        format.json do
          render json: found_post
        end
      end
    rescue ActiveRecord::RecordNotFound => error
    render json: { error: error.message }, status: 404

    rescue StandardError => error
    render json: { error: error.message }, status: 422
    end
  end

  def new
    render 'new.html.erb', locals: { post: Post.new }
  end

  def create
    begin
      post = Post.create(post_params)
      respond_to do |f|
        f.html do
          redirect_to "/posts/#{post.id}"
        end
        f.json do
          render json: post
        end
      end
    rescue ActionController::ParameterMissing => error
      render json: { error: error.message }, status: 422
    end
  end

  def destroy
    if Post.exists?(params[:id])
      deleted_post = Post.destroy(params[:id])
      respond_to do |format|
        format.html do
          redirect_to '/posts'
        end
        format.json do
          render json: deleted_todo
        end
      end

    else
      render json: { error: 'Todo not found' }, status: 404
    end
  end

  def edit
    render 'edit.html.erb', locals: { post: Post.find(params[:id])}
  end

  def update
    begin
      post = Post.update(params[:id], post_params)
      respond_to do |f|
        f.html do
          redirect_to "/posts/#{post.id}"
        end
        f.json do
          render json: post
        end
      end
    rescue ActionController::ParameterMissing => error
      render json: { error: error.message }, status: 422
    end
  end




  private
  def post_params
    params.require(:post).permit(:title, :body)
  end
end
