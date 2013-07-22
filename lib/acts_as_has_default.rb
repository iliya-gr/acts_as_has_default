require 'acts_as_has_default/active_record/acts/default'

module ActsAsHasDefault

  if defined? Rails::Railtie
    require 'rails'
    class Railtie < Rails::Railtie
      initializer 'acts_as_has_default.insert_into_active_record' do
        ActiveSupport.on_load :active_record do
          ActsAsHasDefault::Railtie.insert
        end
      end
    end
  end

  class Railtie
    def self.insert
      if defined?(ActiveRecord)
        ActiveRecord::Base.send(:include, ActiveRecord::Acts::Default)
      end
    end
  end
end

ActsAsHasDefault::Railtie.insert
