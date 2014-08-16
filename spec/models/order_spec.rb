require 'spec_helper'
include Retentiongrid
RSpec.describe Order do

  let :customer do
    FactoryGirl.build(:customer)
  end

  let! :stub_customer_lookup do
    stub_request(:get, "http://retentiongrid.apiary-mock.com/customers/#{customer.customer_id}").to_return(:status => 200, :body => "", :headers => {'Content-Type' => 'application/xml'} )
  end

  subject do
    FactoryGirl.build(:order, customer: customer)
  end

  context "validations" do
    it { expect(subject).to validate_presence_of :order_id }
    it { expect(subject).to validate_presence_of :customer_id }
    it { expect(subject).to validate_presence_of :currency }
    it { expect(subject).to validate_presence_of :total_price }
    it { expect(subject).to validate_presence_of :order_created_at }
    it { expect(subject).to be_valid }
  end

  it "makes sure the order id is populated" do
    expect(subject.order_id).to eql 1
  end

end
