module Deprecate
  class DeprecationError < StandardError;end
  
  def self.included(target)
    target.extend ClassMethods
  end
  
  module ClassMethods
    
    ##
    # === Usage
    # Declare <code>deprecate :method, "Message Ending"</code> after a method definition.
    
    def deprecate(old_method, message_ending = "")
      message = "#{old_method} is deprecated. " + message_ending
      
      # wrap the old method in a new method that complains about being used
      deprecated_method = "deprecated_#{old_method}".to_sym
      class_eval("alias #{deprecated_method} #{old_method}")
      define_method(old_method) do |*args|
        if $DEPRECATE
          raise(DeprecationError, message)
        else
          deprecation_warning("[DEPRECATED] " + message)
        end
        
        self.send(deprecated_method, *args)
      end
    end

  end

private
  
  def deprecation_warning(message)
    if defined?(RAILS_DEFAULT_LOGGER)
      RAILS_DEFAULT_LOGGER.warn(message)
    else
      raise("you need to define deprecation_warning when including Deprecate outside of Rails")
    end
  end
end