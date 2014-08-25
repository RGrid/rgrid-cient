require 'spec_helper'
include Retentiongrid
RSpec.describe Order do

  let :customer do
    FactoryGirl.build(:customer)
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
    expect(subject.order_id).not_to eql nil
  end

end
