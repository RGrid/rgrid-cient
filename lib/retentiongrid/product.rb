module Retentiongrid
  class Product < Resource

    BASE_PATH = '/products'.freeze

    # The set of attributes defined by the API documentation
    ATTRIBUTES_NAMES = [  :product_id, :available, :metadata,
                          :title, :image_url, :currency, :price,
                          :sale_price, :cost_price, :product_url,
                          :product_created_at, :product_updated_at, :metadata
                       ].freeze

    ATTRIBUTES_NAMES.each do |attrib|
     attr_accessor attrib
    end

    def initialize(attribs={})
      super
      if product_created_at.class == "String" && !product_created_at.nil?
        @product_created_at = Time.parse(product_created_at)
      end
      if @product_updated_at.class == "String" && !product_updated_at.nil?
        @product_updated_at = Time.parse(product_updated_at)
      end
    end

    # API Stuff here

    # Find a product with given id
    # @param [Fixnum] product_id the prodct id to be found
    # @return [Product] if found any
    def self.find(product_id)
      begin
        result = Api.get("#{BASE_PATH}/#{product_id}")
        new(result.parsed_response["rg_product"])
      rescue NotFound
        nil
      end
    end

    # Create or update a product with given id
    # @return [Product] if successfully created or updated
    # @raise [Httparty::Error] for all sorts of HTTP statuses.
    def save!
      result = Api.post("#{BASE_PATH}/#{product_id}", body: attributes.to_json)
      Product.new(result.parsed_response["rg_product"])
    end

    # Delete this product at retention grid
    # @return [Boolean] successfully deleted?
    def destroy
      Api.delete("#{BASE_PATH}/#{product_id}")
      true
    end

  end
end