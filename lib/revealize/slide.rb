require 'haml'
module Revealize
  class HamlSlide < Struct.new(:content)
    def render
      Haml::Engine.new(content).render
    end
  end

  class MarkdownSlide < Struct.new(:content)
    
  end
end
