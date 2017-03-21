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
end
