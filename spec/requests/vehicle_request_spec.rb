require 'rails_helper'

describe "Vehicle endpoints" do
  before(:each) do
    @user = create(:user, email: 'user@email.com')
    @user_2 = create(:user, email: 'user2@email.com')
    @vehicle_1 = @user.vehicles.create(make: 'toyota', model: 'carola', id: 1)
    @vehicle_2 = @user.vehicles.create(make: 'toyota', model: 'tacoma')
    @vehicle_3 = @user_2.vehicles.create(make: 'toyota', model: 'tacoma', id: 3)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it 'user POST vehicle' do

    vehicle_info = '{"make": "Toyota", "model": "Tacoma", "year": "2007"}'
    headers = {'Content-Type': 'application/json', 'Accept': 'application/json'}

    post '/vehicles', params: vehicle_info, headers: headers

    expect(response).to be_successful
    results = JSON.parse(response.body, symbolize_names: true)

    expect(results).to be_a Hash

    # expect(results[:data][:attributes][:travel_time]).to eq("1 hour 48 mins")
    #  Need to change response format to aligh with json
    expect(results[:vehicle][:make]).to eq('Toyota')
    expect(results[:vehicle][:model]).to eq('Tacoma')
    expect(results[:vehicle][:year]).to eq('2007')
    expect(results[:vehicle][:fourwd_or_awd]).to eq(false)
    expect(results[:vehicle][:snow_tires]).to eq(false)

  end

  it 'user GET vehicle index' do

    get '/vehicles'

    expect(response).to be_successful
    results = JSON.parse(response.body, symbolize_names: true)

    expect(results).to be_a Hash

    expect(results[:vehicles].count).to eq(3)
    expect(results[:vehicles][0][:make]).to eq('toyota')
    expect(results[:vehicles][0][:model]).to eq('carola')
  end

  it 'user GET vehicle show' do

    get '/vehicles/1'

    expect(response).to be_successful
    results = JSON.parse(response.body, symbolize_names: true)

    expect(results).to be_a Hash

    expect(results[:vehicle][:make]).to eq('toyota')
    expect(results[:vehicle][:model]).to eq('carola')
  end

  it 'user GET vehicle show invalid id' do

    get '/vehicles/100'

    expect(response).to be_successful
    results = JSON.parse(response.body, symbolize_names: true)
    expect(results).to be_a Hash

    expect(results[:status]).to eq(500)
    expect(results[:errors][0]).to eq('vehicle not found')
  end

  it 'user can view their vehicles' do

    get '/user/vehicles'

    expect(response).to be_successful
    results = JSON.parse(response.body, symbolize_names: true)
    expect(results).to be_a Hash

    expect(results[:vehicles].count).to eq(2)
    expect(results[:vehicles][0][:make]).to eq('toyota')
    expect(results[:vehicles][0][:model]).to eq('carola')
  end

  it 'user can update their vehicles' do

    vehicle_info = '{"make": "Toyota", "model": "Tacoma", "year": "2007"}'
    headers = {'Content-Type': 'application/json', 'Accept': 'application/json'}

    patch '/user/vehicles/1', params: vehicle_info, headers: headers

    expect(response).to be_successful
    results = JSON.parse(response.body, symbolize_names: true)
    expect(results).to be_a Hash


    expect(results[:vehicle][:make]).to eq('Toyota')
    expect(results[:vehicle][:model]).to eq('Tacoma')
    expect(results[:vehicle][:year]).to eq('2007')
  end

  it 'user tries to update wrong vehicle' do

    vehicle_info = '{"make": "Toyota", "model": "Tacoma", "year": "2007"}'
    headers = {'Content-Type': 'application/json', 'Accept': 'application/json'}

    patch '/user/vehicles/3', params: vehicle_info, headers: headers

    expect(response).to be_successful
    results = JSON.parse(response.body, symbolize_names: true)
    expect(results).to be_a Hash

    expect(results[:status]).to eq(500)
    expect(results[:errors][0]).to eq('vehicle not found')
  end

  it 'user can delete vehicle' do

    delete '/user/vehicles/1'

    expect(response).to be_successful
    results = JSON.parse(response.body, symbolize_names: true)
    expect(results).to be_a Hash

    expect(results[:status]).to eq(204)
  end

  it 'user can only delete their own vehicle' do

    delete '/user/vehicles/3'

    expect(response).to be_successful
    results = JSON.parse(response.body, symbolize_names: true)
    expect(results).to be_a Hash

    expect(results[:status]).to eq(500)
    expect(results[:errors][0]).to eq('vehicle not found')
  end

end
