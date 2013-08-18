require 'spec_helper'

require 'revealize/deck_list'

module Revealize 
  describe DeckList do
    describe "render" do
      it "creates a list of links to decks" do
        DeckList.new('deck1', 'deck2').render.should include '<a href="/deck1">deck1</a>'
        DeckList.new('deck1', 'deck2').render.should include '<a href="/deck2">deck2</a>'
      end
    end
  end

end
