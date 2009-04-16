require 'test_helper'

class ResourceDeleteTest < ActiveSupport::TestCase
  def setup
    ActionController::Routing::Routes.draw do |map|
      map.resources :pirates
      map.resource :pirate
      map.resources :boats, :except => [:delete]
      map.resource :boat, :except => [:delete]
    end
  end
  
  
  def test_resources_without_delete
    assert_no_recognition :get, "/boats/1/delete", :controller => "boats", :action => "delete", :id => "1" 
  end
  
  def test_resource_without_delete
    assert_no_recognition :get, "/boat/delete", :controller => "boat", :action => "delete"
  end
  
  def test_resources_delete
    assert_recognition :get, "/pirates/1/delete", :controller => "pirates", :action => "delete", :id => "1" 
  end
  
  def test_resource_delete
    assert_recognition :get, "/pirate/delete", :controller => "pirates", :action => "delete"
  end
  
  private
  def assert_recognition(method, path, options)
    result = recognize method, path
    assert_equal options, result
  end
  
  def assert_no_recognition(method, path, options)
    assert_raise ActionController::RoutingError do 
      recognize method, path
    end
  end
  
  def recognize(method, path)
    ActionController::Routing::Routes.recognize_path(path, :method => method)
  end
end
