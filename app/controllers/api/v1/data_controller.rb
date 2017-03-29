class Api::V1::DataController < ApplicationController

 def data
  @user = User.find_by(id: params[:id])
  @calories_data = [@user.fitness_datas.find_by(date: params[:date]).calories, (3500 - @user.fitness_datas.find_by(date: params[:date]).calories)]
  @steps_data = [@user.fitness_datas.find_by(date: params[:date]).steps, (10000 - @user.fitness_datas.find_by(date: params[:date]).steps)]
  @sleep_data = [@user.fitness_datas.find_by(date: params[:date]).sleep, (8 - @user.fitness_datas.find_by(date: params[:date]).sleep)]
  @heart_rate_data = [@user.fitness_datas.find_by(date: params[:date]).heart_rate, (58 - @user.fitness_datas.find_by(date: params[:date]).heart_rate)]
  @distance_data = [@user.fitness_datas.find_by(date: params[:date]).distance, (15 - @user.fitness_datas.find_by(date: params[:date]).distance)]
   @steps_percentage = (@user.fitness_datas.find_by(date: params[:date]).steps.to_f / 10000) * 100

   @sleep_percentage = (@user.fitness_datas.find_by(date: params[:date]).sleep.to_f / 480) * 100
  
   @heart_percentage = (@user.fitness_datas.find_by(date: params[:date]).heart_rate.to_f / 58) * 100
  @calories_percentage = (@user.fitness_datas.find_by(date: params[:date]).calories.to_f / 3500) * 100
   @distance_percentage = (@user.fitness_datas.find_by(date: params[:date]).distance.to_f / 15) * 100
   render "show.json.jbuilder"
 end

end
