module Retentiongrid
  class LineItem < Resource

    BASE_PATH="/line_items".freeze

    # The set of attributes defined by the API documentation
    ATTRIBUTES_NAMES = [  :line_item_id, :rg_order_id, :price, :quantity,
                          :product_id, :variant_id, :sku, :name
                       ].freeze

    ATTRIBUTES_NAMES.each do |attrib|
      attr_accessor attrib
    end

    def initialize(attribs={})
      super
    end

    # relations

    def order=(order)
      @rg_order_id = order.order_id
      @order = order
    end

    # API Stuff here

    # Find a product with given id
    # @param [Fixnum] product_id the prodct id to be found
    # @return [LineItem] if found any
    def self.find(line_item_id)
      begin
        result = Api.get("#{BASE_PATH}/#{line_item_id}")
        new(result.parsed_response["rg_line_item"])
      rescue NotFound
        nil
      end
    end

    # Create or update a line item with given id
    # @return [LineItem] if successfully created or updated
    # @raise [Httparty::Error] for all sorts of HTTP statuses.
    def save!
      result = Api.post("#{BASE_PATH}/#{line_item_id}", body: attributes.to_json)
      new(result.parsed_response["rg_line_item"])
    end

    # Delete this line item at retention grid
    # @return [Boolean] successfully deleted?
    def destroy
      Api.delete("#{BASE_PATH}/#{line_item_id}")
      true
    end

  end
end