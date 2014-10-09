module Retentiongrid

  # Retentiongrid Resource
  # Base class for all API resources.
  #
  class Resource
    include ActiveModel::Validations

    ATTRIBUTES_NAMES = []

    ATTRIBUTES_NAMES.each do |attrib|
      attr_accessor attrib
    end

    def self.base_path
      '/'
    end

    def initialize(attribs={})
      attribs.each do |attrib, value|
        self.send("#{attrib}=", value)
      end
    end

    # Create or update a product with given id
    # @return [Boolean] successfully created or updated?
    def save
      !!(save!) rescue false
    end

    # Return all attributes as a hash
    # @return [Hash]
    def attributes
      self.class::ATTRIBUTES_NAMES.inject({}) do |attribs, attrib_name|
        value = self.send(attrib_name)
        attribs[attrib_name] = value unless value.nil?
        attribs
      end
    end

  end
end