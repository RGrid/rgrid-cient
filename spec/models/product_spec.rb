require 'spec_helper'
include Retentiongrid
RSpec.describe Product do

  subject do
    FactoryGirl.build(:product)
  end

  it "makes sure the product id is populated" do
    expect(subject.product_id).to_not eql nil
  end

end
