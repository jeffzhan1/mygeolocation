require './lib/error_responder.rb'

class ApplicationController < ActionController::Base

  include ErrorResponder

end
