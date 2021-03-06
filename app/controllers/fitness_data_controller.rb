class FitnessDataController < ApplicationController

  def new
    @data = FitnessData.new(user_id: current_user.id)
  end

  def create
    @data = FitnessData.new(steps: params[:steps], heart_rate: params[:heart_rate], distance: params[:distance], calories: params[:calories], date: params[:date], sleep: params[:sleep], special: params[:special], user_id: current_user.id)
    if @data.save
      flash[:succes] = "Your data has been logged!"
      redirect_to "/data/index"
    else
      flash[:error] = "Something went wrong, please input data again!"
      render "new.html.erb"
    end
  end

  def edit
     @data = FitnessData.find_by(user_id: current_user.id)
    if @data.nil?
      redirect_to "/data/new"
    else
      render "edit.html.erb"
    end
  end

  def update
    @data = FitnessData.find_by(id: params[:id])
    @data.assign_attributes(steps: params[:steps], heart_rate: params[:heart_rate], distance: params[:distance], calories: params[:calories], date: params[:date], sleep: params[:sleep], special: params[:special])
     if current_user.fit_user
        @user_activity = Unirest.get("https://api.fitbit.com/1/user/#{current_user.fit_user.uid}/activities/date/2017-03-02.json", headers: {"Authorization" => headers}).body
    if @data.save
      flash[:success] = "Your data has been updated!"
      redirect_to "index.html.erb"
    else
      flash[:error] = "Something went wrong please try again"
    render "/data/@{data.id}/edit"
      end
    end
  end

  def index
    render "index.html.erb"   
  end

end
