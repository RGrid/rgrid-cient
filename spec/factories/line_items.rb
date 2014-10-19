FactoryGirl.define do

  sequence :line_item_id do |n|
    n
  end

  factory :line_item do
    line_item_id
    order
    quantity 1
    price 10.99
    sku 'SDSD'
  end
end