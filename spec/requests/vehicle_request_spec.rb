require 'rails_helper'

describe "Vehicle endpoints" do
  before(:each) do
    @user = create(:user, email: 'user@email.com')
    @user_2 = create(:user, email: 'user2@email.com')
    @vehicle_1 = @user.vehicles.create(make: 'toyota', model: 'carola')
    @vehicle_2 = @user.vehicles.create(make: 'toyota', model: 'carola')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it 'user POST vehicle' do

    vehicle_info = '{"make": "Toyota", "model": "Tacoma", "year": "2007"}'
    headers = {'Content-Type': 'application/json', 'Accept': 'application/json'}

    post '/vehicles', params: vehicle_info, headers: headers

    expect(response).to be_successful
    results = JSON.parse(response.body, symbolize_names: true)
    # binding.pry

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
    # binding.pry

    expect(results).to be_a Hash

    expect(results[:vehicle][:make]).to eq('Toyota')
    expect(results[:vehicle][:model]).to eq('Tacoma')
    expect(results[:vehicle][:year]).to eq('2007')
    expect(results[:vehicle][:fourwd_or_awd]).to eq(false)
    expect(results[:vehicle][:snow_tires]).to eq(false)

  end
end
