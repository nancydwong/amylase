require 'rails_helper'

RSpec.describe Client, :type => :model do
  before { @client = FactoryGirl.create(:client) }
  subject { @client }

  it { should respond_to(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should respond_to(:redshift_schema) }
  it { should respond_to(:salesforce_username) }
  it { should be_valid }
end
