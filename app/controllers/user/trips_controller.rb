class User::TripsController < ApplicationController
  # before_action :require_verified_user
  # before_action :check_user_vehicles, except: [:index, :new, :create]

  # def new
  #   @team = Team.new
  # end

  def create
    @user = current_user
    @vehicle = Vehicle.find_by(id: vehicle_params[:vehicle_id])
    if @user
      @trip = @user.trips.create(trip_params)
      num_times = seat_params[:num_seats].to_i

      if @trip.save
        num_times.times { @trip.seats.create }
        render json: { status: :created, trip: @trip, seats: @trip.seats }
      else
        render json: {status: 500, errors: @trip.errors.full_messages}
      end
      # @trip.save ? (render json: { status: :created, trip: @trip}) :
        # (render json: {status: 500, errors: @trip.errors.full_messages})
    end

    def index
      @trips = current_user.trips

      !@trips.empty? ? (render json: { trips: @trips }) :
        (render json: {status: 404, errors: ['no trips found']})
    end

    # team = current_user.teams.create(team_params)
    # if team.save
    #   flash[:success] = "New team created!"
    #   redirect_to user_teams_path
    # else
    #   flash[:error] = team.errors.full_messages.to_sentence
    #   redirect_to new_user_team_path
    # end
  end

  private

  def trip_params
    params.permit(:origin, :destination, :round_trip)
  end

  def vehicle_params
    params.permit(:vehicle_id)
  end

  def seat_params
    params.permit(:num_seats)
  end

  #
  # def check_user_vehicles
  #   vehicle = Vehicle.find(params[:id])
  #   unless current_user.vehicles.include?(vehicle)
  #     render json: { status: 500, errors: ['vehicle not found']}
  #   end
  # end
end
