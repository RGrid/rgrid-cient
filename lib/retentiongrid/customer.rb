module Retentiongrid
  class Customer
    include ActiveModel::Validations

    attr_accessor :customer_id, :full_name, :first_name, :email,
                  :country, :state, :city, :postal_code, :tags,
                  :accepts_email_marketing

    validates :customer_id, :full_name, presence: true

    def save
      result = Api.post("/customers/#{customer_id}", {})
      Customer.new(result.parsed_response)
    end

    def save!
      !!save
    end

  end
end
