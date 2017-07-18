class AuthenticationsController < ApplicationController
  skip_before_action :for_real!

  def register
    user = User.new(Uploader.upload(user_params))

    if user.save
      render json: user, status: :ok
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by_email(params[:email])
    p user
    if user && user.authenticate(params[:password])
      token = Auth.issue( { id: user.id} )
      render json: { token: token, user: UserSerializer.new(user) } , status: :ok
    else
      render json: {errors: ["Invalid login credentials"] }, status: 401
    end
  end


  private
    def user_params
      params.permit(:name, :username, :first_name, :last_name, :email, :password, :password_confirmation, :base64)
    end
end
