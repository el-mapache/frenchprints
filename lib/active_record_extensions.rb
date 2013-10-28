module ActiveRecordExtensions
  extend ActiveSupport::Concern

  module ClassMethods
    def all_with_attribute(attr)
      self.select(attr).all.map { |instance| instance[attr] }
    end
  end
end

ActiveRecord::Base.send(:include, ActiveRecordExtensions) 
