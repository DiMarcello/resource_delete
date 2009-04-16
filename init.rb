require File.join 'di_marcello/resource_delete'

ActionController::Resources.send :include, DiMarcello::ResourceDelete