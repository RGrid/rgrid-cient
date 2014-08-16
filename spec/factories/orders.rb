FactoryGirl.define do

  sequence :order_id do |n|
    n
  end

  factory :order do
    order_id
    customer
    currency 'EUR'
    total_price 10.99
    order_created_at { Time.now }
  end
end