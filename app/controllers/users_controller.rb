class UsersController < ApplicationController
  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      render json: @user, status: :ok
    else
      head :unauthorized
    end
  end

  def logout
    head :ok
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
