class VehiclesController < ApplicationController

  def create
    # binding.pry
    @user = current_user
    #  might not need this, can probably make private params
    vehicle_params = json_parse(request)
    if @user
      @vehicle = @user.vehicles.create(vehicle_params)
      @vehicle.save ? (render json: { status: :created, vehicle: @vehicle}) :
        (render json: {status: 500, errors: @vehicle.errors.full_messages})
    end
  end

  # def index
  #   @users = User.all
  #   @users ? (render json: { users: @users }) :
  #     (render json: {status: 500, errors: ['no users found']})
  # end
  #
  # def show
  #   @user = User.find_by(id: params[:id])
  #   @user ? (render json: { user: @user }) :
  #     (render json: { status: 500, errors: ['user not found']})
  # end

  # Is this actually any more readable? Looks kinda gross

  private
    # def vehicle_params
    #   params.require(:vehicle).permit(:make, :model, :year, :fourwd_or_awd, :snow_tires)
    # end
end