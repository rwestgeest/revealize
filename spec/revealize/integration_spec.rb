require 'spec_helper'

require 'revealize'

module Revealize
  describe "integration" do
    include Files
    before(:all) do
      mkdir_p "spec/fixtures/root/_slide_decks"
      mkdir_p "spec/fixtures/root/_slides"
      mkdir_p "spec/fixtures/root/_layouts"
    end

    after(:all) do
      rm_r "spec/fixtures/root"
    end

    it "renders a list of slides" do
      a_file("spec/fixtures/root/_slide_decks/deck_1.deck") do 
        %Q{layout 'qwan'
           slide 'slide_1'
           slide 'slide_2'}
      end
      a_file("spec/fixtures/root/_slides/slide_1.haml") do
        haml_content %Q{%section
                            ..%h2 slide 1}
      end
      a_file("spec/fixtures/root/_slides/slide_2.haml") do
        haml_content %Q{%section
                            ..%h2 slide 2}
      end
      a_file("spec/fixtures/root/_layouts/qwan.haml") do 
        haml_content %q{%html
                            ..%body
                            ....= render_slides}
      end
      deck_1 = FileSystemStore.new('spec/fixtures/root').read_deck('deck_1')
      deck_1.render.should == Haml::Engine.new(haml_content %Q{%html
                                                                ..%body
                                                                ....%section
                                                                ......%h2 slide 1
                                                                ....%section
                                                                ......%h2 slide 2}).render
    end



  end
end

