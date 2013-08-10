require 'haml'
module Revealize
  class Slide < Struct.new(:content)
    def render
      Haml::Engine.new(content).render
    end
  end
end
