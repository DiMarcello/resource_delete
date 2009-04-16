module DiMarcello
  module ResourceDelete
    def self.included(base) # :nodoc:
      base.send :alias_method_chain, :resources, :delete
      base.send :alias_method_chain, :resource, :delete
    end
  
    # Adds the following member action:
    #   :delete as a GET action
    def resources_with_delete(*entities, &block)
      options = entities.extract_options!
      options[:member] ||= {}
      options[:member].merge!(:delete => :get)
      entities << options
      resources_without_delete *entities, &block
    end
    
    # Adds the following member action:
    #   :delete as a GET action
    def resource_with_delete(*entities, &block)
      options = entities.extract_options!
      options[:member] ||= {}
      options[:member].merge!(:delete => :get)
      entities << options
      resource_without_delete *entities, &block
    end
    
  end
end
