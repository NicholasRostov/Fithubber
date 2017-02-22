class SessionsController < ApplicationController
  
  def new
    render "new.html.erb"
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "You have succesfully logged into your account!"
      redirect_to "useraccount.html.erb"
    else
      flash[:warning] = "Wrong log in credentials have been entered..."
      redirect_to "/login"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Succesfully logged out!"
    redirect_to "/login"
  end
end
