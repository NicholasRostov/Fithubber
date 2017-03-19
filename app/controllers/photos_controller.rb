class PhotosController < ApplicationController
 def create
  @photo = Photo.new(image: params[:image], user_id: current_user.id)
  if @photo.save
    flash[:success] = "The photo was added!"
    redirect_to "/account"
  else
    flash[:warning] = "The upload has failed please try again."
    render "useraccount.html.erb"
    end
  end
end