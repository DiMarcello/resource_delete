require 'rubygems'
require 'active_support'
require 'active_support/test_case'
require 'models/pirates_controller'

module ResourceDeleteTestHelpers
  def draw_routes(&block)
    returning ActionController::Routing::RouteSet.new do |set|
      class << set; def clear!; end; end
      set.draw &block
      silence_warnings{ ActionController::Routing.const_set 'Routes', set }
    end
  end
end