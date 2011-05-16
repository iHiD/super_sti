module HasExtraData
  class Hook
    def has_extra_data(&block)

      table_name = "#{self.name.underscore}_data"
      klass = Class.new(ActiveRecord::Base) do
        set_table_name(table_name)
      end
      klass.class_eval &block
      self.const_set "Data", klass

      has_one :data, :class_name => "#{self.name}::Data"
      before_create :build_data
    end
  end
end
