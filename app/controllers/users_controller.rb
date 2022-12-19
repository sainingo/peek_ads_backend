class UsersController < ApplicationController
    before_action :authenticate_request, except: [:create]

    def create
        user = User.new(user_params)
        if user.save
            render json: { user: user}
        else
            render json: {error: user.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def show
        render json: { user: @current_user}
    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :username, :password, :password_confirmation, :picture)
    end
end