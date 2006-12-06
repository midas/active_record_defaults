module ActiveRecord
  module Defaults
    def self.included(base)
      return if base.included_modules.include?(ActiveRecord::Defaults::InstanceMethods)
      
      base.extend ClassMethods
      base.send(:include, InstanceMethods)
      
      base.send :alias_method, :initialize_without_defaults, :initialize
      base.send :alias_method, :initialize, :initialize_with_defaults
    end
    
    module ClassMethods
      # Define default values for attributes on new records. Requires a hash of <tt>attribute => value</tt> pairs,
      # or a single attribute with an associated block.
      # The value can be a specific object, like a string or an integer, or a Proc that returns the default value when called.
      # 
      #   class Person < ActiveRecord::Base
      #     defaults :name => 'My name', :city => Proc.new { 'My city' }
      #     
      #     defaults :birthdate do |person|
      #       Date.today if person.wants_birthday_today?
      #     end
      #   end
      #   
      # The default values are only used if the key is not present in the given attributes.
      # 
      #   p = Person.new
      #   p.name # "My name"
      #   p.city # "My city"
      #   
      #   p = Person.new(:name => nil)
      #   p.name # nil
      #   p.city # "My city"
      def defaults(defaults, &block)
        default_objects = case
          when defaults.is_a?(Hash)
            defaults.map { |attribute, value| Default.new(attribute, value) }
            
          when defaults.is_a?(Symbol) && block
            Default.new(defaults, block)
            
          else
            raise "pass either a hash of attribute/default pairs, or a single attribute with a block"
        end
        
        write_inheritable_array :attribute_defaults, [*default_objects]
      end
      
      alias_method :default, :defaults
    end
    
    module InstanceMethods
      def initialize_with_defaults(attributes = nil)
        initialize_without_defaults(attributes)
        
        attribute_keys = (attributes || {}).keys.map(&:to_s)
        
        if attribute_defaults = self.class.read_inheritable_attribute(:attribute_defaults)
          attribute_defaults.each do |default|
            next if attribute_keys.include?(default.attribute)
            
            # Ignore a default value for association_id if association has been specified
            reflection = self.class.reflections[default.attribute.to_sym]
            next if reflection and reflection.macro == :belongs_to and attribute_keys.include?(reflection.primary_key_name)
            
            # Ignore a default value for association if association_id has been specified
            reflection = self.class.reflections.values.find { |r| r.respond_to?(:primary_key_name) && r.primary_key_name == default.attribute }
            next if reflection and reflection.macro == :belongs_to and attribute_keys.include?(reflection.name.to_s)
            
            send("#{default.attribute}=", default.value(self))
          end
        end
        
        defaults if respond_to?(:defaults)
        
        yield self if block_given?
      end
    end
    
    class Default
      attr_reader :attribute
      
      def initialize(attribute, value)
        @attribute, @value = attribute.to_s, value
      end
      
      def value(record)
        if @value.respond_to?(:call)
          @value.call(record)
        else
          @value
        end
      end
    end
  end
end

class ActiveRecord::Base
  include ActiveRecord::Defaults
end
