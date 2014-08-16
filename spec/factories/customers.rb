FactoryGirl.define do

  sequence :customer_id do |n|
    n
  end

  factory :customer do
    customer_id
    full_name "Chris Tucker"
  end
end