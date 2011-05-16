ENV["RAILS_ENV"] ||= 'test'

require 'rails'
require 'rspec-rails'
require 'active_record'

$:.unshift File.dirname(__FILE__) + '/../lib'

# This isn't working so I have to use the second line...
require File.dirname(__FILE__) + '/../lib/has_extra_data'
ActiveRecord::Base.send(:extend, HasExtraData::Hook)
 
ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
 
# AR keeps printing annoying schema statements
$stdout = StringIO.new

ActiveRecord::Base.logger
ActiveRecord::Schema.define(:version => 1) do
  create_table :test_classes do |t|
  end
  
  create_table :test_class_data do |t|
    t.integer :test_class_id, :null => false
  end
end