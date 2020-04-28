require 'rails_helper'

describe "Vehicle endpoints" do
  before(:each) do
    @user = create(:user, email: 'user@email.com')
    @user_2 = create(:user, email: 'user2@email.com')
    @vehicle_1 = @user.vehicles.create(make: 'toyota', model: 'carola', id: 1)
    @vehicle_2 = @user.vehicles.create(make: 'toyota', model: 'tacoma')
    @vehicle_3 = @user_2.vehicles.create(make: 'toyota', model: 'tacoma', id: 3)
    @trip_1 = @user.trips.create(origin: 'Denver, CO', destination: 'Salida, CO')
    @trip_2 = @user.trips.create(origin: 'Denver, CO', destination: 'Aspen, CO')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it 'user can POST trip' do

    vehicle_info = '{"vehicle_id": "1", "num_seats": "3", "origin": "Denver, CO", "destination": "Vail, CO", "round_trip": "true"}'
    headers = {'Content-Type': 'application/json', 'Accept': 'application/json'}

    post '/user/trips', params: vehicle_info, headers: headers

    expect(response).to be_successful
    results = JSON.parse(response.body, symbolize_names: true)

    expect(results).to be_a Hash
    # expect(results[:data][:attributes][:travel_time]).to eq("1 hour 48 mins")
    #  Need to change response format to aligh with json
    expect(results[:trip][:origin]).to eq('Denver, CO')
    expect(results[:trip][:round_trip]).to eq(true)
    expect(results[:trip][:destination]).to eq('Vail, CO')
    expect(results[:seats].count).to eq(3)
  end

  it 'user can GET their trips' do

    get '/user/trips'

    expect(response).to be_successful
    results = JSON.parse(response.body, symbolize_names: true)

    expect(results).to be_a Hash

    # expect(results[:data][:attributes][:travel_time]).to eq("1 hour 48 mins")
    #  Need to change response format to aligh with json
    expect(results[:trips].count).to eq(2)
    expect(results[:trips][0][:origin]).to eq('Denver, CO')
    expect(results[:trips][0][:destination]).to eq('Salida, CO')
    expect(results[:trips][0][:round_trip]).to eq(true)

  end

  it 'user has no trips' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_2)

    get '/user/trips'

    expect(response).to be_successful
    results = JSON.parse(response.body, symbolize_names: true)

    expect(results).to be_a Hash
    # expect(results[:data][:attributes][:travel_time]).to eq("1 hour 48 mins")
    #  Need to change response format to aligh with json
    expect(results[:status]).to eq(404)
    expect(results[:errors][0]).to eq('no trips found')

  end
end
