module Retentiongrid
  # Retentiongrid Order
  #
  # To create a new Retentiongrid::Order object:
  #   order = Retention::Order.new(:id => "123", :lat => "52.2", :lon => "13.4", :changeset => "12", :user => "fred", :uid => "123", :visible => true, :timestamp => "2005-07-30T14:27:12+01:00")
  #
  # To get a order from the API:
  #   order = Retention::Order.find(17)
  #
  class Order
    include ActiveModel::Validations

    ATTRIBUTES_NAMES = [  :order_id, :customer_id, :status, :total_price, :total_discounts,
                          :currency, :canceled_shipped, :canceled_shop_fault, :order_created_at
                       ].freeze

    ATTRIBUTES_NAMES.each do |attrib|
      attr_accessor attrib
    end

    attr_accessor :customer

    validates :order_id, :customer_id, :currency, :total_price, :order_created_at, presence: true

    def initialize(attribs={})
      attribs.each do |attrib, value|
        self.send("#{attrib}=", value)
      end
      @order_created_at = Time.parse(order_created_at) unless order_created_at.nil?
    end


    # relations

    def customer=(customer)
      @customer_id = customer.customer_id
      @customer = customer
    end

    # API Stuff here

    # Find an order with given id
    # @param [Fixnum] order_id the order id to be found
    # @return [Order] if found any
    def self.find(order_id)
      begin
        result = Api.get("/orders/#{order_id}")
        new(result.parsed_response)
      rescue NotFound
        nil
      end
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
