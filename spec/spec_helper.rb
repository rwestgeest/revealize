$: << 'lib'
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
Rspec.configure do |config|
  config.filter_run_excluding :broken => true
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
end
