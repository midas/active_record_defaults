$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'active_record/defaults'

module ActiveRecordDefaults
  VERSION = '1.0.0'
end

ActiveRecord::Base.send( :include, ActiveRecord::Defaults ) if defined?( ActiveRecord::Base )