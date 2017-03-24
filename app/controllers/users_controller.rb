class UsersController < ApplicationController
  
  def new
    render "new.html.erb"
  end

  def search
    search_result = params[:search_result]
    @user = User.find_by("full_name LIKE ?", "%#{search_result}%")
    if @user
      render "useraccount.html.erb"
    else
      flash[:warning] = "User does not exist"
      redirect_to "/account/#{current_user.id}"
    end
  end

  def create
    @user = User.new(full_name: params[:full_name], email: params[:email], username: params[:username], password: params[:password], password_confirmation: params[:password_confirmation])
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
    @user.assign_attributes(full_name: params[:full_name], username: params[:username], email: params[:email], dob: params[:dob], gender: params[:gender], address_1: params[:address_1], address_2: params[:address_2], state: params[:state], city: params[:city], zipcode: params[:zipcode], phone_number: params[:phone_number], education: params[:education], profession: params[:profession], organization: params[:organization])
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
      @user = User.find_by(id: params[:id])
      @today_datas = @user.fitness_datas.where(date: Date.today)
      headers = "Bearer #{session[:fitbit_token]}"
      gon.calories_data = @user.fitness_datas.find_by(date: "2017-03-14").calories
      gon.steps_data = @user.fitness_datas.find_by(date: "2017-03-14").steps
      gon.sleep_data = @user.fitness_datas.find_by(date: "2017-03-14").sleep
      gon.heart_rate_data = @user.fitness_datas.find_by(date: "2017-03-14").heart_rate
      gon.distance_data = @user.fitness_datas.find_by(date: "2017-03-14").distance
      render "useraccount.html.erb"
    else
      redirect_to "/login"
    end
  end



end
