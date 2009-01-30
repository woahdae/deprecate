module Deprecate
  class DeprecationError < StandardError;end
  
  def self.included(target)
    target.extend ClassMethods
  end
  
  module ClassMethods
    
    def deprecate(old_method, message_ending = "")
      message = "#{old_method} is deprecated. " + message_ending
      
      deprecated_method = "deprecated_#{old_method}".to_sym
      class_eval("alias #{deprecated_method} #{old_method}")
      instance_eval do
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