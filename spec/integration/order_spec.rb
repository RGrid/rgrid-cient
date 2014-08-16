require 'spec_helper'
include Retentiongrid
RSpec.describe Order do

  before do
    WebMock.disable_net_connect!
  end

  subject do
    FactoryGirl.build(:order)
  end

  let(:api) { Api.new }

  context '#find' do

  end

  context '#create' do
  end

  context '#update' do
  end

  context '#delete' do
  end

end
