class WelcomeController < ApplicationController
  def index
     respond_to do |format|
      format.html do
        render 'index.html.erb', locals: { post: Post.all }
      end
      format.json do
        render json: Post.all
      end
    end
  end

  def about

    respond_to do |format|
      format.html do
        render 'about.html.erb', locals: { post: Post.all }
      end
      format.json do
        render json: Post.all
      end
    end
  end
end
