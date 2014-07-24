module Retentiongrid
  class Order

    ATTRIBUTES_NAMES = [  :order_id, :customer_id, :status, :total_price, :total_discounts,
                          :currency, :canceled_shiped, :canceled_shop_fault, :order_created_at
                       ]

    ATTRIBUTES_NAMES.each do |attrib|
      attr_accessor attrib
    end

    def initialize(attribs={})
      attribs.each do |attrib, value|
        self.send("#{attrib}=", value)
      end
      @order_created_at = Time.parse(order_created_at) unless order_created_at.nil?
    end

    def attributes
      ATTRIBUTES_NAMES.inject({}) do |attribs, attrib_name|
        attribs[attrib_name] = self.send(attrib_name)
        attribs
      end
    end

    def save
      res = Api.post("/orders/#{order_id}", attributes)
    end

    def destroy
      res = Api.delete("/orders/#{order_id}")
    end

  end
end
