class ApplicationController < ActionController::Base
  protect_from_forgery

  def self.skip_before_filter(*names, &block)
    names = names.map do |name|
      if name.class == Class
        _process_action_callback.detect do |callback|
          callback.raw_filter == name
        end.filter
      else
        name
      end
    end

    super
  end

end
