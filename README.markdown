## deprecate

A very simple (40 line) gem/rails plugin that helps deprecate methods.

Once you declare a method deprecated, it will start logging "[DEPRECATED] method is depricated.",
plus any custom message (see usage below). Default message level is warn.

Set <code>$DEPRECATE</code> to true, ex. in your development environment, to have it start throwing errors
instead of logging.

### Usage

Declare <code>depricate :method, "Message"</code> after a method definition.

Note that the use case that inspired this was renaming old methods whose names are no longer informative
given our current project complexity. So, know that declaring <code>alias :old :new</code> before
<code>depricate</code> works fine for this.

### Example

This is the class used for the specs:

    class TestObject
      include Deprecate
  
      def return_hello
        "hello"
      end
      deprecate(:return_hello, "Please use 'hello' instead")
  
      def goodbye
        "goodbye"
      end
      alias :return_goodbye :goodbye
      deprecate(:return_goodbye, "Please use 'goodbye' instead")

      def say(greeting)
        greeting
      end
      deprecate(:say, "It was completely useless")
  
      private
  
      def deprecation_warning(message)
        # You don't have to define this unless you're outside of Rails.
        # Default for Rails is to use RAILS_DEFAULT_LOGGER.warn
      end
    end
