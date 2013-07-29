require 'active_record'
require 'logger'

ActiveRecord::Base.logger = Logger.new('/dev/null')
ActiveRecord::Base.configurations = YAML.load_file(File.join(File.dirname(__FILE__), 'db/database.yml'))
ActiveRecord::Base.establish_connection(ENV['DB'] || 'sqlite3mem')

ActiveRecord::Migration.verbose = false

require 'db/schema.rb'
require File.join(File.dirname(__FILE__), '../lib/acts_as_has_default')

class Address < ActiveRecord::Base
  belongs_to :user

  acts_as_has_default scope: :user_id
end

class User < ActiveRecord::Base
  has_many :addresses
end