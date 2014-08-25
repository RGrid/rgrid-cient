require 'spec_helper'
include Retentiongrid
RSpec.describe Customer do

  before do
    WebMock.disable_net_connect!
  end

  def valid_customer
    <<-EOF
    { "rg_customer":
      { "customer_id": "C123",
        "first_name": "John",
        "full_name": "John Smith",
        "email": "john.smith@example.com",
        "country": "DE",
        "city": "Berlin",
        "state": "Berlin",
        "postal_code": "10437",
        "tags": "wholesale",
        "accepts_email_marketing": "true"
      }
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

    subject do
      FactoryGirl.build(:customer)
    end

    before :each do
      stub_request(:delete, "http://retentiongrid.apiary-mock.com/customers/#{subject.customer_id}").to_return(:status => 204, :body => '')
    end

    it "should send delete to API" do
      expect(subject.destroy).to eql true
    end
  end

end
