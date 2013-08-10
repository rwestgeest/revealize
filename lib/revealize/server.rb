require 'haml'
require 'revealize/file_system_store'

module Revealize
  class Server < Sinatra::Base
    get '/:slide_deck' do
      FileSystemStore.new('.').read_deck(params[:slide_deck]).render
    end
  end
end
