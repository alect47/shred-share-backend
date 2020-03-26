class UsersController < ApplicationController

  def index
    @users = User.all
    if @users
      render json: {
        users: @users
      }
    else
      render json: {
        status: 500,
        errors: ['no users found']
      }
    end
  end

  def show
    @user = User.find(params[:id])
   if @user
      render json: {
        user: @user
      }
    else
      render json: {
        status: 500,
        errors: ['user not found']
      }
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!
      render json: {
        status: :created,
        user: @user
      }
    else
      render json: {
        status: 500,
        errors: @user.errors.full_messages
      }
    end
  end

  # def create
  #   @user = User.create(user_params)
  #  if @user.save
  #   response = { message: 'User created successfully'}
  #   render json: response, status: :created
  #  else
  #   render json: @user.errors, status: :bad
  #  end
  # end

  private
    def user_params
      params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
    end

  # def user_params
  #   params.permit(
  #     :name,
  #     :email,
  #     :password
  #   )
  # end
end
