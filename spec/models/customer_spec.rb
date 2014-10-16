require 'spec_helper'
include Retentiongrid
RSpec.describe Customer do

  subject do
    FactoryGirl.build(:customer)
  end

  it "sets the base path correctly" do
    expect(Customer::BASE_PATH).to eql '/customers'
  end

  it "makes sure the customer id is populated" do
    expect(subject.customer_id).to_not eql nil
  end

end
