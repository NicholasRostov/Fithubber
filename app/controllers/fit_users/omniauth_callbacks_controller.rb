class FitUsers::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def fitbit_oauth2
    @user = FitUser.from_omniauth(request.env["omniauth.auth"])
    session[:fitbit_token] = request.env["omniauth.auth"]["credentials"]["token"]
    data = request.env["omniauth.auth"]
      if current_user
        @fit = FitUser.new(email: current_user.email, password: "password", password_confirmation: "password", provider: data["provider"], uid: data["uid"], user_id: current_user.id)
          headers = "Bearer #{session[:fitbit_token]}"
          @fit.save
      end
      @user_profile = Unirest.get("https://api.fitbit.com/1/user/#{current_user.fit_user.uid}/profile.json", headers: { "Authorization" => headers }).body
        if current_user.update(gender: @user_profile["user"]["gender"], full_name: @user_profile["user"]["fullName"], dob: @user_profile["user"]["dateOfBirth"])
          redirect_to "/account/#{current_user.id}"
        else
          flash[:warning] = "You must create an account first."
          redirect_to "/login"
        end

      heart_api = Unirest.get("https://api.fitbit.com/1/user/#{current_user.fit_user.uid}/activities/heart/date/today/1m.json", headers: { "Authorization" => headers}).body["activities-heart"]
          heart_data = []
          heart_api.each do |heart|
          heart_data << heart["value"]["restingHeartRate"]
          heart_rate = heart["value"]["restingHeartRate"] || 0
          # binding.pry
          heart_day = current_user.fitness_datas.find_by(date: heart["dateTime"], user_id: current_user.id)
            if !heart_day && heart_rate == 0
              FitnessData.create(heart_rate: heart_rate, date: heart["dateTime"], user_id: current_user.id)
            elsif heart_day && heart_rate
              heart_day.update(heart_rate: heart_rate)
            end
          end
          
      sleep_data = Unirest.get("https://api.fitbit.com/1/user/#{current_user.fit_user.uid}/sleep/minutesAsleep/date/today/1m.json", headers: { "Authorization" => headers}).body["sleep-minutesAsleep"]
          sleep_data.each do |sleep|
            sleep_day = current_user.fitness_datas.find_by(date: sleep["dateTime"],
              user_id: current_user.id)
            if sleep_day.nil?
              FitnessData.create(sleep: sleep["value"], date: sleep["dateTime"],
                user_id: current_user.id)
            elsif sleep_day
              sleep_day.update(sleep: sleep["value"])
            end
          end

      activities = ["steps", 'calories', 'distance'] 
      activities.each do |activity|
      activity_data = Unirest.get("https://api.fitbit.com/1/user/#{current_user.fit_user.uid}/activities/#{activity}/date/today/1m.json", headers: { "Authorization" => headers }).body["activities-#{activity}"]
              # binding.pry
        activity_data.each do |entry|
          fitness_day = current_user.fitness_datas.find_by(date: entry["dateTime"], user_id: current_user.id)
          if fitness_day.nil?
            FitnessData.create(activity => entry["value"], date: entry["dateTime"], user_id: current_user.id)
          elsif fitness_day
            fitness_day.update(activity => entry["value"])
          end
         end
      end
  end
        
  def failure
    redirect_to root_path
  end
end
