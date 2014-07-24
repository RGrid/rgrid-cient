module Retentiongrid
  class Order

    ATTRIBUTES_NAMES = [  :order_id, :customer_id, :status, :total_price, :total_discounts,
                          :currency, :canceled_shiped, :canceled_shop_fault, :order_created_at
                       ].freeze

    ATTRIBUTES_NAMES.each do |attrib|
      attr_accessor attrib
    end

    def initialize(attribs={})
      attribs.each do |attrib, value|
        self.send("#{attrib}=", value)
      end
      @order_created_at = Time.parse(order_created_at) unless order_created_at.nil?
    end

    def self.find(order_id)
      result = Api.get("/orders/#{order_id}")
      Order.new(result.parsed_response)
    end

    def save
      result = Api.post("/orders/#{order_id}", attributes)
      Order.new(result.parsed_response)
    end

    def destroy
      res = Api.delete("/orders/#{order_id}")
    end

    def attributes
      ATTRIBUTES_NAMES.inject({}) do |attribs, attrib_name|
        attribs[attrib_name] = self.send(attrib_name)
        attribs
      end
    end

  end
end
