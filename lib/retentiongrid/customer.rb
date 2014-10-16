module Retentiongrid

  # Retentiongrid Customer
  #
  # To create a new Retentiongrid::Customer object:
  #   customer = Retentiongrid::Customer.new(customer_id: 'C123', full_name: 'Chris Tucker').save
  #
  # To get a order from the API:
  #   customer = Retentiongrid::Customer.find('C123')
  #
  class Customer < Resource

    BASE_PATH = '/customers'

    # The set of attributes defined by the API documentation
    ATTRIBUTES_NAMES = [ :customer_id, :full_name, :first_name, :email,
                         :country, :state, :city, :postal_code, :tags,
                         :accepts_email_marketing ].freeze

    ATTRIBUTES_NAMES.each do |attrib|
      attr_accessor attrib
    end

    # API Stuff here

    # Find a customer with given id
    # @param [Fixnum] customer_id the customer id to be found
    # @return [Customer] if found any
    def self.find(customer_id)
      begin
        result = Api.get("#{BASE_PATH}/#{customer_id}")
        new(result.parsed_response["rg_customer"])
      rescue NotFound
        nil
      end
    end

    # Create or update a customer with given id
    # @return [Customer] if successfully created or updated
    # @raise [Httparty::Error] for all sorts of HTTP statuses.
    def save!
      result = Api.post("#{BASE_PATH}/#{customer_id}", body: attributes.to_json)
      Customer.new(result.parsed_response["rg_customer"])
    end

    # Delete this customer at retention grid
    # @return [Boolean] successfully deleted?
    def destroy
      Api.delete("#{BASE_PATH}/#{customer_id}")
      true
    end
  end
end
