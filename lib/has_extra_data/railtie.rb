require 'has_extra_data'
require 'rails'

module HasExtraData
  class Railtie < Rails::Railtie
    railtie_name :has_extra_data
    
    config.to_prepare do
      ActiveRecord::Base.send(:extend, HasExtraData::Hook)
    end
  end
end
