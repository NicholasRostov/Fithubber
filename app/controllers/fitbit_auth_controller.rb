class FitbitAuthController < ApplicationController
  def index
  end
  
  def make_request
    # The request is made to Fitbit

  end

  def get_response
      # # Callback from Fitbit Oauth

    
      # # Oauth Access Credentials

      # oauth_token = params[:oauth_token]
      # oauth_verifier = params[:oauth_verifier]
    
      # data = request.env['omniauth.auth']
      # activities = get_user_activities(data)
      # render json:activities


      client = Fitbit::Client.new({:consumer_key => ENV['FITBIT_CLIENT_ID'], :consumer_secret => ENV['FITBIT_CLIENT_SECRET']})

      request_token = client.request_token
      token = request_token.token
      secret = request_token.secret

      puts "Go to http://www.fitbit.com/oauth/authorize?oauth_token=#{token} and then enter the verifier code below and hit Enter"
      verifier = gets.chomp

      access_token = client.authorize(token, secret, { :oauth_verifier => verifier })

      puts "Verifier is: "+verifier
      puts "Token is:    "+access_token.token
      puts "Secret is:   "+access_token.secret
    end

  private

  def get_user_activities(data)
    fitbit_user_id = data["uid"]
    user_secret = data["credentials"]
  end
end
