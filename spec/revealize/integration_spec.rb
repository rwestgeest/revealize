require 'spec_helper'

require 'revealize'

module Revealize

  describe "integration" do
    include FileUtils
    before(:all) do
      mkdir_p "spec/fixtures/root/slide_decks"
      mkdir_p "spec/fixtures/root/slides"
      mkdir_p "spec/fixtures/root/layouts"
    end

    after(:all) do
      rm_r "spec/fixtures/root"
    end

    it "renders a list of slides" do
      a_file("spec/fixtures/root/slide_decks/deck_1.deck") do 
        %Q{layout 'qwan'
           slide 'slide_1'
           slide 'slide_2'}
      end
      a_file("spec/fixtures/root/slides/slide_1.haml") do
        haml_content %Q{%section
                            ..%h2 slide 1}
      end
      a_file("spec/fixtures/root/slides/slide_2.haml") do
        haml_content %Q{%section
                            ..%h2 slide 2}
      end
      a_file("spec/fixtures/root/layouts/qwan.haml") do 
        haml_content %q{%html
                            ..%body
                            ....= slides}
      end
      deck_1 = FileSystemStore.new('spec/fixtures/root').read_deck('deck_1')
      deck_1.render.should == Haml::Engine.new(haml_content %Q{%html
                                                                ..%body
                                                                ....%section
                                                                ......%h2 slide 1
                                                                ....%section
                                                                ......%h2 slide 2}).render
    end


    def a_file(filepath, &block)
      file_writer = FileWriter.new(filepath)
      file_writer.with_content(yield) if block_given?
      file_writer
    end

    def haml_content(content)
      content.gsub(/^ */,'').gsub('.',' ')
    end

    class FileWriter < Struct.new(:filepath)
      def with_content(content)
        File.open(filepath, "w+") { |f| f.write(content) }
      end
    end

  end
end

