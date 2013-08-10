require 'thor'
require 'sinatra'
require 'revealize/server'
module Revealize
  class Commands < Thor
    desc "server", "start the revealize server"
    def server
      app = Rack::Builder.new do
        run Server
      end
      Rack::Server.start :app => app 
    end
  end
end
