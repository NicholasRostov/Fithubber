class UsersController < ApplicationController
 def new
    render "new.html.erb"
  end

  def create
    user = User.new(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], username: params[:username], password_digest: params[:password_digest], password_confirmation: params[:password_confirmation])
    if user.save
      session[:user_id] = user.id
      flash[:success] = "You have succesfully created your account!"
      redirect_to "/useraccount"
    else
      flash[:warning] = "Please fill out all fields"
      redirect_to "/signup"
    end
  end
end

