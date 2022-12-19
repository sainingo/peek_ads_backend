class AuthorizeApiRequest
    def self.call(headers)
        token = headers['Authorization']
        begin
            decoded_token = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
            user_id = decoded_token['user_id']
            user = User.find(user_id)
            if user.token == token
                return user
            else
                raise Exception.new('Invalid Token')
            end
        rescue JWT::DecodeError => e
            raise Exception.new('Not Authorized')
        end
    end
end