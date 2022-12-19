module JsonWebToken
    def self.encode(payload, secret)
        JWT.encode(payload, secret)
    end

    def self.decode(token, secret)
        JWT.decode(token, secret)[0]
        rescue
            nil
    end
end