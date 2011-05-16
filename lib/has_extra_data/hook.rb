module HasExtraData
  module Hook
    def has_extra_data(&block)

      table_name = "#{self.name.underscore.gsub("/", "_")}_data"
      klass = Class.new(ActiveRecord::Base) do
      
        set_table_name(table_name)
        
        def self.parent_klass=(klass)
          @parent_klass = klass
        end

        def self.belongs_to(sym, *args)
          super(sym, *args)
          #@parent_klass.has_one sym, :through => :data
        end
      end
      klass.parent_klass = self
      klass.class_eval &block if block_given?
      self.const_set "Data", klass
  
      has_one :data, :class_name => "#{self.name}::Data"
      before_create :get_data
      
      define_method :get_data do
        data || build_data
      end
      
      define_method "attributes=" do |new_attributes, guard_protected_attributes = true|
        get_data.attribute_names.each do |attr_name|
          unless respond_to? attr_name
            self.class.send(:define_method, attr_name) do
              data.send(attr_name)
            end
          end
          unless respond_to? "#{attr_name}="
            self.class.send(:define_method, "#{attr_name}=") do |val|
              data.send("#{attr_name}=", val)
            end
          end
        end
        super(new_attributes, guard_protected_attributes)
      end
      
      define_method :method_missing do |sym, *args|
      
        # Firstly, try the original method_missing because there may well be 
        # some magic piping that will return a result.
        begin
          super(sym, args)
        rescue
          
          # Do we want to raise the initial exception, for a cleaner stack trace?
          #exception = $!
          #begin
            get_data.send(sym, *args)
          #rescue
          #  raise exception
          #end
        end
      end
    end
  end
end
