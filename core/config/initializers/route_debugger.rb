module Spree
  def self.r
    @_route_debugger ||= Spree::RouteDebugger.new
  end

  class RouteDebugger
    include Rails.application.routes.url_helpers
    include Spree::Core::Engine.routes.url_helpers
  end
end