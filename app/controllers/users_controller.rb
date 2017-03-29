class UsersController < ApplicationController
  
  def new
    render "new.html.erb"
  end

  def search
    search_result = params[:search_result].capitalize
    @user = User.find_by("full_name LIKE ?", "%#{search_result}%")
    headers = "Bearer #{session[:fitbit_token]}"
    gon.calories_data = [@user.fitness_datas.find_by(date: "2017-03-01").calories, (3500 - @user.fitness_datas.find_by(date: "2017-03-01").calories)]
    # binding.pry
    gon.calories_percentage = (@user.fitness_datas.find_by(date: "2017-03-01").calories.to_f / 3500) * 100
    gon.steps_data = [@user.fitness_datas.find_by(date: "2017-03-01").steps, (10000 - @user.fitness_datas.find_by(date: "2017-03-01").steps)]
    gon.steps_percentage = (@user.fitness_datas.find_by(date: "2017-03-01").steps.to_f / 10000) * 100
    gon.sleep_data = [@user.fitness_datas.find_by(date: "2017-03-01").sleep, (480 - @user.fitness_datas.find_by(date: "2017-03-01").sleep)]
     gon.sleep_percentage = (@user.fitness_datas.find_by(date: "2017-03-01").sleep.to_f / 480) * 100
    gon.heart_rate_data = [@user.fitness_datas.find_by(date: "2017-03-01").heart_rate, (58 - @user.fitness_datas.find_by(date: "2017-03-01").heart_rate)]
     gon.heart_percentage = (@user.fitness_datas.find_by(date: "2017-03-01").heart_rate.to_f / 58) * 100
    gon.distance_data = [@user.fitness_datas.find_by(date: "2017-03-01").distance, (15 - @user.fitness_datas.find_by(date: "2017-03-01").distance)]
     gon.distance_percentage = (@user.fitness_datas.find_by(date: "2017-03-01").distance.to_f / 15) * 100
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
      # @today_datas = @user.fitness_datas.where(date: Date.today)
      headers = "Bearer #{session[:fitbit_token]}"
      headers = "Bearer #{session[:fitbit_token]}"
      gon.calories_data = [@user.fitness_datas.find_by(date: "2017-03-01").calories, (3500 - @user.fitness_datas.find_by(date: "2017-03-01").calories)]
      # binding.pry
      gon.calories_percentage = (@user.fitness_datas.find_by(date: "2017-03-01").calories.to_f / 3500) * 100
      gon.steps_data = [@user.fitness_datas.find_by(date: "2017-03-01").steps, (10000 - @user.fitness_datas.find_by(date: "2017-03-01").steps)]
      gon.steps_percentage = (@user.fitness_datas.find_by(date: "2017-03-01").steps.to_f / 10000) * 100
      gon.sleep_data = [@user.fitness_datas.find_by(date: "2017-03-01").sleep, (480 - @user.fitness_datas.find_by(date: "2017-03-01").sleep)]
       gon.sleep_percentage = (@user.fitness_datas.find_by(date: "2017-03-01").sleep.to_f / 480) * 100
      gon.heart_rate_data = [@user.fitness_datas.find_by(date: "2017-03-01").heart_rate, (58 - @user.fitness_datas.find_by(date: "2017-03-01").heart_rate)]
       gon.heart_percentage = (@user.fitness_datas.find_by(date: "2017-03-01").heart_rate.to_f / 58) * 100
      gon.distance_data = [@user.fitness_datas.find_by(date: "2017-03-01").distance, (15 - @user.fitness_datas.find_by(date: "2017-03-01").distance)]
       gon.distance_percentage = (@user.fitness_datas.find_by(date: "2017-03-01").distance.to_f / 15) * 100
      render "useraccount.html.erb"
    else
      redirect_to "/login"
    end
  end



end
