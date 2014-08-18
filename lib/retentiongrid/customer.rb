module Retentiongrid
  class Customer
    include ActiveModel::Validations

    ATTRIBUTES_NAMES = [ :customer_id, :full_name, :first_name, :email,
                         :country, :state, :city, :postal_code, :tags,
                         :accepts_email_marketing ].freeze

    ATTRIBUTES_NAMES.each do |attrib|
      attr_accessor attrib
    end

    validates :customer_id, :full_name, presence: true

    def initialize(attribs={})
      attribs.each do |attrib, value|
        self.send("#{attrib}=", value)
      end
    end

    # API Stuff here

    # Find a customer with given id
    # @param [Fixnum] customer_id the customer id to be found
    # @return [Customer] if found any
    def self.find(customer_id)
      begin
        result = Api.get("/customers/#{customer_id}")
        new(result.parsed_response["rg_customer"])
      rescue NotFound
        nil
      end
    end



    def save
      result = Api.post("/customers/#{customer_id}", body: attributes.to_json)
      Customer.new(result.parsed_response["rg_customer"])
    end

    def save!
      !!save
    end

    def destroy
      res = Api.delete("/customers/#{customer_id}")
    end

    def attributes
      ATTRIBUTES_NAMES.inject({}) do |attribs, attrib_name|
        value = self.send(attrib_name)
        attribs[attrib_name] = value unless value.nil?
        attribs
      end
    end

  end
end
