# Revealize

Creates serves and compiles slide decks using reveal js markdown and
haml

In my company we use one repository for all training slide decks. In the
process of migrating from OpenOffice to revealjs I needed something that
allowed me to 

* manage several slide decks (for different presentations) using one
pile of slides
* use different templates for the decks
* write slides in haml or markdown
* use revealjs as slideshow engine

## Installation

Add this line to your application's Gemfile:

    gem 'revealize'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install revealize

## Usage

This gem is very much work in progress. 
 
TODO

To start the server

```bash
revealize server
```

You might want to use rerun to make sure the server reruns when a file
changes

open a browser and type localhost:8080 to view the sameple presentation

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
