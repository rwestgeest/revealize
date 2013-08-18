require 'spec_helper'
require 'capybara/rspec'

require 'revealize'

module Revealize
  describe "integration" do
    include Files
    before(:all) do
      mkdir_p "spec/fixtures/root/#{FileSystemStore::SLIDE_DECKS_DIR}"
      mkdir_p "spec/fixtures/root/#{FileSystemStore::SLIDES_DIR}"
      mkdir_p "spec/fixtures/root/#{FileSystemStore::LAYOUTS_DIR}"
      a_file("spec/fixtures/root/#{FileSystemStore::SLIDE_DECKS_DIR}/deck_1.deck") do 
        %Q{layout 'qwan'
           slide 'slide_1'
           slide 'slide_2'}
      end
    end

    after(:all) do
      rm_r "spec/fixtures/root"
    end

    describe 'reading a deck' do
      it "renders a list of slides" do
        a_file("spec/fixtures/root/#{FileSystemStore::SLIDES_DIR}/slide_1.haml") do
          haml_content %Q{%section
                            ..%h2 slide 1}
        end
        a_file("spec/fixtures/root/#{FileSystemStore::SLIDES_DIR}/slide_2.haml") do
          haml_content %Q{%section
                            ..%h2 slide 2}
        end
        a_file("spec/fixtures/root/#{FileSystemStore::LAYOUTS_DIR}/qwan.haml") do 
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

    describe 'listing decks' do
      context "without decks" do
        it 'renders a list of links to a deck' do
          decks = FileSystemStore.new('spec/fixtures/root').decks
          Capybara.string(decks.render).should_not have_selector("a[href='/#{FileSystemStore::SLIDE_DECKS_DIR}/deck_1']")
        end
      end

      context "with decks" do
        it 'renders a list of links to a deck' do
          a_file("spec/fixtures/root/#{FileSystemStore::SLIDE_DECKS_DIR}/deck_1.deck").with_content ""
          decks = FileSystemStore.new('spec/fixtures/root').decks
          Capybara.string(decks.render).should_not have_selector("a[href='/#{FileSystemStore::SLIDE_DECKS_DIR}/deck_1']")
        end
      end
    end

  end
end

