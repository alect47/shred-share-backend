class User::VehiclesController < ApplicationController
  # before_action :require_verified_user
  before_action :check_user_vehicles, except: [:index, :new, :create]

  def index
    @vehicles = current_user.vehicles
    # binding.pry
    @vehicles ? (render json: { vehicles: @vehicles }) :
      (render json: {status: 500, errors: ['no vehicles found']})
  end

  def update
    vehicle = current_user.vehicles.find(params[:id])
    vehicle.update(vehicle_params) ? (render json: { status: :updated, vehicle: vehicle}) :
      (render json: {status: 500, errors: vehicle.errors.full_messages})
  end

  def destroy
    vehicle = current_user.vehicles.find(params[:id])
    vehicle.destroy
    render json: { status: 204 }
  end

  # def show
  #   @team = current_user.teams.find_by_id(params[:id].to_i)
  #   if team_player_params[:benched]
  #     team_player = TeamPlayer.find(team_player_params[:team_player])
  #     team_player.update(benched: team_player_params[:benched])
  #   end
  #   @players = @team.players.order(sort_column + " " + sort_direction)
  # end

  # def new
  #   @team = Team.new
  # end

  # def create
  #   team = current_user.teams.create(team_params)
  #   if team.save
  #     flash[:success] = "New team created!"
  #     redirect_to user_teams_path
  #   else
  #     flash[:error] = team.errors.full_messages.to_sentence
  #     redirect_to new_user_team_path
  #   end
  # end

  # def edit
  #   @team = current_user.teams.find(params[:id])
  # end
  #
  # def update
  #   team = current_user.teams.find(params[:id])
  #   if team.update(team_params)
  #     flash[:success] = "Team name updated!"
  #     redirect_to user_teams_path
  #   else
  #     flash[:error] = team.errors.full_messages.to_sentence
  #     redirect_to edit_user_team_path(team)
  #   end
  # end
  #

  private

  def vehicle_params
    params.require(:vehicle).permit(:make, :model, :year, :fourwd_or_awd, :snow_tires)
  end
  #
  # def team_player_params
  #   params.permit(:team_player, :benched)
  # end
  #
  def check_user_vehicles
    vehicle = Vehicle.find(params[:id])
    unless current_user.vehicles.include?(vehicle)
      render json: { status: 500, errors: ['vehicle not found']}
    end
  end
end
