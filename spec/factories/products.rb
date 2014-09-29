FactoryGirl.define do

  sequence :product_id do |n|
    n
  end

  factory :product do
    product_id
    title "A fancy product"
    currency 'EUR'
    price 31.50
    sale_price 30.00
    cost_price 23.00
    available true
    image_url 'http://example.com/images/1.png'
    product_updated_at { Time.now - 86400 }
    product_created_at { Time.now - 161024 }
  end
end