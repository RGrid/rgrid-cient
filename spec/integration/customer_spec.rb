require 'spec_helper'
include Retentiongrid
RSpec.describe Customer do

  before do
    WebMock.disable_net_connect!
  end

  def valid_customer
    <<-EOF
    {
        "customer_id": "C123",
        "full_name": "Chris Tucker",
        "first_name": "Chris",
        "email": "chris@tucker.com",
        "country": "DE",
        "state": "Berlin",
        "city": "Berlin",
        "postal_code": "10117",
        "accepts_email_marketing": true
    }
    EOF
  end

  let(:api) { Api.new }

  context '#find' do

    subject do
      stub_request(:get, "http://retentiongrid.apiary-mock.com/customers/C123").
        to_return(:status => 200, :body => valid_customer, :headers => {'Content-Type' => 'application/json'})
      Customer.find('C123')
    end

    it "should build a Customer from API response" do
      expect(subject.class).to eql Retentiongrid::Customer
    end

    it "should parse customer_id correctly" do
      expect(subject.customer_id).to eql 'C123'
    end

  end

  context '#create' do
  end

  context '#delete' do
  end

end
