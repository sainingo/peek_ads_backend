module Auth
    def current_user
        @current_user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    end

    def authenticate_request
        if auth_token.blank? || decoded_auth_token.blank?
            render json: {error: "Token is missing or invalid"}, status: :unauthorized
        end
    end

    private

    def decoded_auth_token
        @decoded_auth_token ||= JsonWebToken.decode(auth_token, Rails.application.secrets.secret_key_base)
    end

    def auth_token
        @auth_token ||= request.headers['Authorization']
    end
end