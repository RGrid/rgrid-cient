require 'spec_helper'
include Retentiongrid
RSpec.describe Customer do

  subject do
    FactoryGirl.build(:customer)
  end

  context "validations" do
    it { expect(subject).to validate_presence_of :customer_id }
    it { expect(subject).to validate_presence_of :full_name }
    it { expect(subject).to be_valid }
  end

  it "makes sure the customer id is populated" do
    expect(subject.customer_id).to_not eql nil
  end

end
