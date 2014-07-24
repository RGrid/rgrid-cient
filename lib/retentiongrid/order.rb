module Retentiongrid
  class Order
    attr_accessor :order_id, :customer_id, :status, :total_price, :total_discounts, :currency,
                  :canceled_shiped, :canceled_shop_fault, :order_created_at

    def initialize(attribs={})
      attribs.each do |attrib, value|
        self.send("#{attrib}=", value)
      end
      @order_created_at    = Time.parse(order_created_at) unless order_created_at.nil?
      @canceled_shiped     = canceled_shiped.to_bool      unless canceled_shiped.nil?
      @canceled_shop_fault = canceled_shop_fault.to_bool  unless canceled_shop_fault.nil?
    end
  end
end
