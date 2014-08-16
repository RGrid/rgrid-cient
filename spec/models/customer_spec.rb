require 'spec_helper'
include Retentiongrid
RSpec.describe Customer do

  subject do
    FactoryGirl.build(:customer)
  end

  let! :stub_customer_lookup do
    stub_request(:get, "http://retentiongrid.apiary-mock.com/customers/#{subject.customer_id}").to_return(:status => 200, :body => "", :headers => {'Content-Type' => 'application/xml'} )
  end

  context "validations" do
    it { expect(subject).to validate_presence_of :customer_id }
    it { expect(subject).to validate_presence_of :full_name }
    it { expect(subject).to be_valid }
  end

  it "makes sure the order id is populated" do
    expect(subject.customer_id).to eql 1
  end

end
