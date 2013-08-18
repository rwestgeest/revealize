require 'haml'
require 'revealize/file_system_store'

module Revealize
  class Server < Sinatra::Base
    set :public_folder, '.'
    get %r{.*favicon.*} do
      ''
    end

    get '/' do
      FileSystemStore.new('.').decks.render
    end

    get '/:slide_deck' do
      FileSystemStore.new('.').read_deck(params[:slide_deck]).render
    end
  end
end
