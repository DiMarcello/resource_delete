module DiMarcello
  module ResourceDelete
    def self.included(base) # :nodoc:
      base.send :alias_method_chain, :action_options_for, :delete
      
      base::Resource::DEFAULT_ACTIONS << :delete
      base::Resource.send :include, Resource
    end
    
    private
    def action_options_for_with_delete(action, resource, method = nil, resource_options = {})
      return action_options_for_without_delete(action, resource, method, resource_options) unless action.to_sym == :delete
      default_options = { :action => action.to_s }
      require_id = !resource.kind_of?(ActionController::Resources::SingletonResource)
      
      default_options.merge(add_conditions_for(resource.conditions, method || :get)).merge(resource.requirements(require_id))
    end
    
    module Resource
      def self.included(base)
        base.send :alias_method_chain, :add_default_actions, :delete
      end
      
      def add_default_actions_with_delete
        add_default_actions_without_delete
        add_default_action(member_methods, :get, :delete)
      end
    end
  end
end
