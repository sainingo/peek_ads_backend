class SessionsController < ApplicationController
    skip_before_action :authenticate_request
    
    def login
        user = User.find_by(email: params[:email])
        if user&.authenticate(params[:password])
            token = JWT.encode({user_id: user.id}, Rails.application.secrets.secret_key_base)
            render json: {token: token}
        else
            render json: {error: "Invalid email or password"}, status: :unauthorized
        end
    end

    def destroy
        # logout 
        token = request.headers['Authorization'].split(' ').last
        decoded_token = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
        user = User.find(decoded_token['user_id'])
        user.update(token: nil)
    end
end