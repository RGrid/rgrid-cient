require 'spec_helper'
include Retentiongrid
RSpec.describe Product do

  before do
    WebMock.disable_net_connect!
  end

  def valid_order
    <<-EOF
    { "rg_product":
      { "product_id": "123",
        "product_created_at": "2014-03-11 13:35:10",
        "available": true,
        "metadata": "",
        "product_updated_at": "2014-03-12 13:35:10",
        "title": "An awesome product",
        "image_url": "http://example.com/images/large.png",
        "currency": "EUR",
        "price": 169.00,
        "sale_price": 169.00,
        "cost_price": 99.00,
        "product_url": "http://example.com/products/aweseome"
      }
    }
    EOF
  end

  let(:api) { Api.new }

  context '#find' do

    subject do
      stub_request(:get, "http://retentiongrid.apiary-mock.com/products/123").
        to_return(:status => 200, :body => valid_order, :headers => {'Content-Type' => 'application/json'})
      Product.find('123')
    end

    it "should retry upon 429 TooManyRequests" do
      stub_request(:get, "http://retentiongrid.apiary-mock.com/products/123").
        to_return(:status => 429, :body => '429 Too Many Requests (5 request/s on average allowed. Burst of max 10/s require you to wait 1 second.)', :headers => {'Content-Type' => 'text/plain'}).then.
        to_return(:status => 200, :body => valid_order, :headers => {'Content-Type' => 'application/json'})
      Product.find('123')
    end

    it "should build a Product from API response" do
      expect(subject.class).to eql Retentiongrid::Product
    end

    it "should parse product_id correctly" do
      expect(subject.product_id).to eql '123'
    end

    it "should parse available correctly" do
      expect(subject.available).to eql true
    end

    it "should parse title correctly" do
      expect(subject.title).to eql 'An awesome product'
    end

    it "should parse price correctly" do
      expect(subject.price).to eql 169.0
    end

    it "should parse sale_price correctly" do
      expect(subject.sale_price).to eql 169.0
    end

    it "should parse cost_price correctly" do
      expect(subject.cost_price).to eql 99.0
    end

    it "should parse currency correctly" do
      expect(subject.currency).to eql "EUR"
    end

    it "should parse product_created_at correctly" do
      expect(subject.product_created_at).to eql Time.parse("2014-03-11 13:35:10")
    end

    it "should parse product_updated_at correctly" do
      expect(subject.product_updated_at).to eql Time.parse("2014-03-12 13:35:10")
    end

  end

  context '#create' do
  end

  context '#delete' do

    before :each do
      stub_request(:delete, "http://retentiongrid.apiary-mock.com/products/#{subject.product_id}").to_return(:status => 204, :body => '')
    end

    it "should send delete to API" do
      expect(subject.destroy).to eql true
    end

  end

end
