require 'spec_helper'
include Retentiongrid
RSpec.describe Product do

  subject do
    FactoryGirl.build(:product)
  end

  it "sets the base path correctly" do
    expect(Product::BASE_PATH).to eql '/products'
  end

  it "makes sure the product id is populated" do
    expect(subject.product_id).to_not eql nil
  end

end
