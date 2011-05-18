module SuperSTI
  module Hook
    
    ######
    # has_extra_data(options = {})
    #
    # In it's most raw form, this method creates an associated Data class, 
    # which seamlessly adds attributes and methods to the main class
    #
    # If passed a block, extra attributes can be set on the data table, 
    # methods (e.g. has_many) can be called, and other methods can be defined.
    #
    # Options:
    #   table_name: The table name of the class
    #####
    def has_extra_data(options = {}, &block)

      table_name = options[:table_name] || "#{self.name.underscore.gsub("/", "_")}_data"
      klass = Class.new(ActiveRecord::Base) do
        set_table_name(table_name)
      end
      klass.class_eval &block if block_given?
      self.const_set "Data", klass
  
      # Add a reference to a data object that gets created when this is created
      has_one :data, :class_name => "#{self.name}::Data", :foreign_key => options[:foreign_key]
      before_create :get_data
      
      # A helper method which gets the existing data or builds a new object
      define_method :get_data do
        data || build_data
      end
      
      # Override respond_to? to check both this object and its data object.
      define_method "respond_to?" do |sym, include_private = false|
        super(sym, include_private) || get_data.respond_to?(sym, include_private)
      end
      
      # Override method_missing to check both this object and it's data object for any methods or magic functionality.
      # Firstly, try the original method_missing because there may well be 
      # some magic piping that will return a result and then try the data object.
      define_method :method_missing do |sym, *args|
        begin
          super(sym, args)
        rescue
          get_data.send(sym, *args)
        end
      end
    end
  end
end
