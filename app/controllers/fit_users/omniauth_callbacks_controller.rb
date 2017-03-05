class FitUsers::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def fitbit_oauth2
    @user = FitUser.from_omniauth(request.env["omniauth.auth"])
    # session[:fitbit_data] = request.env["omniauth.auth"]
    session[:fitbit_token] = request.env["omniauth.auth"]["credentials"]["token"]

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Fitbit Oauth2") if is_navigational_format?
    else
      data = request.env["omniauth.auth"]
      if current_user
        @fit = FitUser.new(email: current_user.email, password: "password", password_confirmation: "password", provider: data["provider"], uid: data["uid"], user_id: current_user.id)
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