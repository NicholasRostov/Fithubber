class Api::V1::PostsController < ApplicationController
  def create
    @post = Post.new(body: params[:body], photo: params[:photo], url: params[:url])
    @post.save
    render "show.json.jbuilder"
  end

  def index
    @posts = Post.all
    render "index.json.jbuilder"
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    if @post.destroy
      render json: {message: "This post has been deleted."}
    else
      render json: { errors: @person.errors.full_messages }, status: 422
    end
  end
end
