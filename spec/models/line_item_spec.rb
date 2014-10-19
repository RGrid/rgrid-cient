require 'spec_helper'
include Retentiongrid
RSpec.describe LineItem do

  let :customer do
    FactoryGirl.build(:customer)
  end

  let :order do
    FactoryGirl.build(:order, customer: customer)
  end

  subject do
    FactoryGirl.build(:line_item, order: order)
  end

  it "sets the base path correctly" do
    expect(subject.class::BASE_PATH).to eql '/line_items'
  end

  it "makes sure the line item id is populated" do
    expect(subject.line_item_id).to_not eql nil
  end

  context 'associations' do

    it "sets up order association" do
      expect(subject.order_id).to eql order.order_id
    end
  end

end
