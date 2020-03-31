require 'rails_helper'

describe "Vehicle endpoints" do
  before(:each) do
    @user = create(:user, email: 'user@email.com')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it 'user adds vehicle' do

    vehicle_info = '{"make": "Toyota", "model": "Tacoma", "year": "2007"}'
    headers = {'Content-Type': 'application/json', 'Accept': 'application/json'}

    post '/vehicles', params: vehicle_info, headers: headers

    expect(response).to be_successful
    results = JSON.parse(response.body, symbolize_names: true)

    expect(results).to be_a Hash

    expect(results[:data][:attributes][:travel_time]).to eq("1 hour 48 mins")

  end
end
