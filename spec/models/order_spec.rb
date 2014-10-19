require 'spec_helper'
include Retentiongrid
RSpec.describe Order do

  let :customer do
    FactoryGirl.build(:customer)
  end

  subject do
    FactoryGirl.build(:order, customer: customer)
  end

  it "sets the base path correctly" do
    expect(subject.class::BASE_PATH).to eql '/orders'
  end

  it "makes sure the order id is populated" do
    expect(subject.order_id).not_to eql nil
  end

  context 'associations' do

    it "sets up customer association" do
      expect(subject.customer_id).to eql customer.customer_id
    end
  end


end
