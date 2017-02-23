class UsersController < ApplicationController
 def new
    render "new.html.erb"
  end

  def create
    @user = User.new(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], username: params[:username], password: params[:password], password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "You have succesfully created your account!"
      render "useraccount.html.erb"
    else
      flash[:warning] = "Please fill out all fields"
      redirect_to "/signup"
    end
  end
  
  def edit
     @user = User.find_by(id: current_user.id)
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.assign_attributes(first_name: params[:first_name], last_name: params[:last_name], username: params[:username], email: params[:email], dob: params[:dob], gender: params[:gender], address_1: params[:address_1], address_2: params[:address_2], state: params[:state], city: params[:city], zipcode: params[:zipcode], phone_number: params[:phone_number], education: params[:education], profession: params[:profession], organization: params[:organization])
    if @user.save
      flash[:succes] = "Your account information has been updated."
      redirect_to "useraccount.html.erb"
    else
      flash[:error] = "Something went wrong please try again"
    render "/#{@user.id}"
    end
  end

  def show
   if current_user
  @user = current_user
  @today_datas = @user.fitness_datas.where(date: Date.today)
  render "useraccount.html.erb"
else
  redirect_to "/login"
  end
  end

end
