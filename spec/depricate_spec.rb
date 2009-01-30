require File.dirname(__FILE__) + '/spec_helper'

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

describe "deprecate" do
  before(:each) do
    @object = TestObject.new
  end

  it "should still execute the old method" do
    $DEPRECATE = false
    @object.return_hello.should == "hello"
  end

  it "should warn when not in $DEPRECATE mode" do
    $DEPRECATE = false
    @object.should_receive(:deprecation_warning).with("[DEPRECATED] return_hello is deprecated. Please use 'hello' instead")
    @object.return_hello
  end
  
  it "should raise errors when in $DEPRECATE mode" do
    $DEPRECATE = true
    lambda { @object.return_hello }.should raise_error("return_hello is deprecated. Please use 'hello' instead")
  end
  
  describe "when aliasing" do
    it "should still execute the old method" do
      $DEPRECATE = false
      @object.return_goodbye.should == "goodbye"
    end

    it "should warn when not in $DEPRECATE mode" do
      $DEPRECATE = false
      @object.should_receive(:deprecation_warning).with("[DEPRECATED] return_goodbye is deprecated. Please use 'goodbye' instead")
      @object.return_goodbye
    end

    it "should raise errors when in $DEPRECATE mode" do
      $DEPRECATE = true
      lambda { @object.return_goodbye }.should raise_error("return_goodbye is deprecated. Please use 'goodbye' instead")
    end
  end
  
  describe "when the method uses parameters" do
    it "should still execute the old method" do
      $DEPRECATE = false
      @object.say("goodbye").should == "goodbye"
    end

    it "should warn when not in $DEPRECATE mode" do
      $DEPRECATE = false
      @object.should_receive(:deprecation_warning).with("[DEPRECATED] say is deprecated. It was completely useless")
      @object.say("goodbye")
    end

    it "should raise errors when in $DEPRECATE mode" do
      $DEPRECATE = true
      lambda { @object.say("goodbye") }.should raise_error("say is deprecated. It was completely useless")
    end
  end
end
