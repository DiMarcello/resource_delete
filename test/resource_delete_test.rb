require 'test_helper'

class ResourceDeleteTest < ActiveSupport::TestCase
  def setup
    ActionController::Routing::Routes.draw do |map|
      map.resources :pirates
      map.resource :pirate
    end
  end
  
  def test_resources_delete
    assert_recognition :get, "/pirates/1/delete", :controller => "pirates", :action => "delete", :id => "1" 
  end
  
  def test_resource_delete
    assert_recognition :get, "/pirate/delete", :controller => "pirates", :action => "delete"
  end
  
  private
    def assert_recognition(method, path, options)
      result = ActionController::Routing::Routes.recognize_path(path, :method => method)
      assert_equal options, result
    end
end
