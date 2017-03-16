class FitUsers::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def fitbit_oauth2
    @user = FitUser.from_omniauth(request.env["omniauth.auth"])
    session[:fitbit_token] = request.env["omniauth.auth"]["credentials"]["token"]
      data = request.env["omniauth.auth"]
      if current_user
        @fit = FitUser.new(email: current_user.email, password: "password", password_confirmation: "password", provider: data["provider"], uid: data["uid"], user_id: current_user.id)
        headers = "Bearer #{session[:fitbit_token]}"
        @fit.save
        @user_profile = Unirest.get("https://api.fitbit.com/1/user/#{current_user.fit_user.uid}/profile.json", headers: { "Authorization" => headers }).body
        activities = ["steps", 'calories'] 
        activities.each do |activity|
          activity_data = Unirest.get("https://api.fitbit.com/1/user/#{current_user.fit_user.uid}/activities/#{activity}/date/today/1m.json", headers: { "Authorization" => headers }).body["activities-#{activity}"]
          activity_data.each do |entry|
            fitness_day = current_user.fitness_datas.find_by(date: entry["dateTime"], user_id: current_user.id)
            if fitness_day.nil?
              FitnessData.create(activity => entry["value"], date: entry["dateTime"], user_id: current_user.id)
            elsif fitness_day
              fitness_day.update(activity => entry["value"])
            end
          end
        end
        current_user.update(gender: @user_profile["user"]["gender"], full_name: @user_profile["user"]["fullName"], dob: @user_profile["user"]["dateOfBirth"])
        redirect_to "/account"
      else
        flash[:warning] = "You must create an account first."
        redirect_to "/login"
      end
    # end
  end

  def failure
    redirect_to root_path
  end
end