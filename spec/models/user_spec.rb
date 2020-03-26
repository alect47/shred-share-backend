require 'rails_helper'

describe User, type: :model do
  describe "relationships" do

  end

  describe 'validations' do
    # it {should validate_presence_of :user_name}
    it {should validate_presence_of :email}
  end

end
#
