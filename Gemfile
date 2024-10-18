# frozen_string_literal: true

source 'https://rubygems.org'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '7.2.1'

# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem 'propshaft', '0.9.1'

# Use postgresql as the database for Active Record
gem 'pg', '1.5.8'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '6.4.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '1.18.4', require: false

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem 'jsbundling-rails', '1.3.1'
# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem 'cssbundling-rails', '1.4.1'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails', '2.0.6'
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails', '1.3.4'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', '2.0.6', platforms: %i[windows jruby]

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', '1.9.2', platforms: %i[mri windows], require: 'debug/prelude'
end

group :development do
  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem 'brakeman', '6.2.2', require: false

  # RuboCop is a Ruby code style checking and code formatting tool.
  gem 'rubocop', '1.66.1', require: false
  # Automatic Rails code style checking tool.
  gem 'rubocop-rails', '2.26.1', require: false
  # A collection of RuboCop cops to check for performance optimizations in Ruby code.
  gem 'rubocop-performance', '1.21.1', require: false
end
