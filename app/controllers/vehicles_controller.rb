class VehiclesController < ApplicationController

  def create
    @user = current_user
    if @user
      @vehicle = @user.vehicles.create(vehicle_params)
      @vehicle.save ? (render json: { status: :created, vehicle: @vehicle}) :
        (render json: {status: 500, errors: @vehicle.errors.full_messages})
    end
  end

  def index
    @vehicles = Vehicle.all
    @vehicles ? (render json: { vehicles: @vehicles }) :
      (render json: {status: 500, errors: ['no vehicles found']})
  end
  
  def show
    @vehicle = Vehicle.find_by(id: params[:id])
    @vehicle ? (render json: { vehicle: @vehicle }) :
      (render json: { status: 500, errors: ['vehicle not found']})
  end

  # Is this actually any more readable? Looks kinda gross

private
    def vehicle_params
      params.require(:vehicle).permit(:make, :model, :year, :fourwd_or_awd, :snow_tires)
    end
end
