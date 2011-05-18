require 'rails'
require 'super_sti'

module SuperSTI
  class Railtie < Rails::Railtie
    railtie_name :super_sti
    
    config.to_prepare do
      ActiveRecord::Base.send(:extend, SuperSTI::Hook)
    end
  end
end
