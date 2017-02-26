class ActivitiesController < ApplicationController
  def create
    @activity = Activity.find_by(name: params[:name])
    if @activity
      @activities = @activity
    else
      @activities = Activity.new(name: params[:name])
      @activities.save
    end
    user_activity = UserActivity.new(user_id: current_user.id, activity_id: @activities.id)
    if user_activity.save
      flash[:success] = "Yopu have added your activity!"
    end
    redirect_to "/users/#{current_user.id}/edit"
  end
end
