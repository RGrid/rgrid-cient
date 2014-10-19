require 'spec_helper'
include Retentiongrid
RSpec.describe LineItem do

  before do
    WebMock.disable_net_connect!
  end

  def valid_line_items
    <<-EOF
    {
      "rg_item": {
        "line_item_id": "20377",
        "order_id": 12977635,
        "price": "4.5",
        "quantity": 1,
        "product_id": 25,
        "variant_id": null,
        "sku": "",
        "name": "Protestsülze"
      }
    }
    EOF
  end

  let(:api) { Api.new }

  context '#find' do

    subject do
      stub_request(:get, "http://retentiongrid.apiary-mock.com/line_items/20377").
        to_return(:status => 200, :body => valid_line_items, :headers => {'Content-Type' => 'application/json'})
      LineItem.find(20377)
    end

    it "should build a LineItem from API response" do
      expect(subject.class).to eql Retentiongrid::LineItem
    end

    it "should parse line_item_id correctly" do
      expect(subject.line_item_id).to eql '20377'
    end

  end

  context '#create' do
  end

  context '#delete' do

    before :each do
      stub_request(:delete, "http://retentiongrid.apiary-mock.com/line_items/#{subject.line_item_id}").to_return(:status => 204, :body => '')
    end

    it "should send delete to API" do
      expect(subject.destroy).to eql true
    end
  end

end
