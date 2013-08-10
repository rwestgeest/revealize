require 'haml'
module Revealize
  class DeckTemplate < Struct.new(:layout_file)
    def render(deck)
      Haml::Engine.new(layout_file).render(deck)
    end
  end

  class EmptyTemplate
    def render(context)
      context.render_slides
    end
  end
end
