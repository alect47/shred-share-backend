class UsersController < ApplicationController

  def index
    @users = User.all
    @users ? (render json: { users: @users }) :
      (render json: {status: 500, errors: ['no users found']})
  end

  def show
    @user = User.find_by(id: params[:id])
    @user ? (render json: { user: @user }) :
      (render json: { status: 500, errors: ['user not found']})
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

  private
    def user_params
      params.permit(:name, :email, :password, :password_confirmation)
      #  Might need to switch back to this to hookup react
      # params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
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
