require 'spec_helper'

describe "HasExtraData" do

  before :each do
    if Object.const_defined?("TestClass")
      Object.send(:remove_const, "TestClass")
    end
    @klass = Class.new(ActiveRecord::Base)
    Object.const_set "TestClass", @klass
  end

  it "has_extra_data can be called on an AR class" do
    lambda{
      @klass.class_eval{has_extra_data}
    }.should_not raise_error
  end
  
  it "has_extra_data adds the data method" do
    @klass.class_eval{has_extra_data}
    @klass.new.should respond_to(:data)
  end
  
  it "creates data with the test class" do
    @klass.class_eval{has_extra_data}
    obj = @klass.create!
    obj.data.id.should_not == 0
  end
  
end