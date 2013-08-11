require 'haml'
require 'kramdown'
require 'yaml'

module Revealize
  class HamlSlide < Struct.new(:content)
    def render
      Haml::Engine.new(content).render
    end
  end


  class MarkdownSlide < Struct.new(:raw_content)
    def render
      render_markdown
      Haml::Engine.new("%section#{section_options}\n  =rendered_markdown").render(self) 
    end

    def render_markdown
      @rendered_markdown = Kramdown::Document.new(content_without_preamble, :auto_ids => false).to_html
    end
    def rendered_markdown
      @rendered_markdown
    end

    def content_without_preamble
      return raw_content unless raw_content.start_with?("---")
      raw_content = self.raw_content.sub("---\n", '')
      pre_amble, content = raw_content.split("---\n")
      @options = YAML.load(pre_amble)
      return content
    end

    def section_options
      return '' unless @options
      return %Q{(#{@options.to_a.map {|option| "data-#{ option.first }='#{option.last}'" }.join(' ')})}
    end
  end
end
