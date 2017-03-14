class FitUsers::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def fitbit_oauth2
    @user = FitUser.from_omniauth(request.env["omniauth.auth"])
    session[:fitbit_token] = request.env["omniauth.auth"]["credentials"]["token"]
    if @user.persisted?
      redirect_to "/account"
    else
      data = request.env["omniauth.auth"]
      if current_user
        @fit = FitUser.new(email: current_user.email, password: "password", password_confirmation: "password", provider: data["provider"], uid: data["uid"], user_id: current_user.id)
        @user_profile = Unirest.get("https://api.fitbit.com/1/user/#{current_user.fit_user.uid}/profile.json", headers: { "Authorization" => headers }).body
        current_user.update(  in parameters here**)
        @fit.save
        redirect_to "/account"
      else
        flash[:warning] = "You must create an account first."
        redirect_to "/login"
      end
    end
  end

  def failure
    redirect_to root_path
  end
end