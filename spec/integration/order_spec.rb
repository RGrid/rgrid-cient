require 'spec_helper'
include Retentiongrid
RSpec.describe Order do

  before do
    WebMock.disable_net_connect!
  end

  def valid_order
    <<-EOF
    {
      "order_id": "A123",
      "customer_id": "C123",
      "status": "ok",
      "total_price": 12.00,
      "total_discounts": 1.00,
      "currency": "EUR",
      "canceled_shipped": false,
      "canceled_shop_fault": false,
      "order_created_at": "2014-03-12 13:35:10"
    }
    EOF
  end

  let(:api) { Api.new }

  context '#find' do

    subject do
      stub_request(:get, "http://retentiongrid.apiary-mock.com/orders/A123").
        to_return(:status => 200, :body => valid_order, :headers => {'Content-Type' => 'application/json'})
      Order.find('A123')
    end

    it "should build an Order from API response" do
      expect(subject.class).to eql Retentiongrid::Order
    end

    it "should parse order_id correctly" do
      expect(subject.order_id).to eql 'A123'
    end

    it "should parse customer_id correctly" do
      expect(subject.customer_id).to eql 'C123'
    end

    it "should parse status correctly" do
      expect(subject.status).to eql 'ok'
    end

    it "should parse total_price correctly" do
      expect(subject.total_price).to eql 12.0
    end

    it "should parse total_discounts correctly" do
      expect(subject.total_discounts).to eql 1.0
    end

    it "should parse currency correctly" do
      expect(subject.currency).to eql "EUR"
    end

    it "should parse canceled_shipped correctly" do
      expect(subject.canceled_shipped).to eql false
    end

    it "should parse canceled_shop_fault correctly" do
      expect(subject.canceled_shop_fault).to eql false
    end

    it "should parse order_created_at correctly" do
      expect(subject.order_created_at).to eql Time.parse("2014-03-12 13:35:10")
    end

  end

  context '#create' do
  end

  context '#delete' do
  end

end
