# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.3.5'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '7.2.1.1'

# Use postgresql as the database for Active Record
gem 'pg', '1.5.8'

# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem 'propshaft', '1.1.0'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '6.4.3'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '1.18.4', require: false

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', '2.0.6', platforms: %i[windows jruby]

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem 'jsbundling-rails', '1.3.1'
# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem 'cssbundling-rails', '1.4.1'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails', '2.0.11'
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails', '1.3.4'

# High-level wrapper for processing images for the web with ImageMagick or libvips.
gem 'image_processing', '1.13.0'

# Ancestry allows the records of a ActiveRecord model to be organized in a tree structure
gem 'ancestry', '4.3.3'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', '1.9.2', platforms: %i[mri windows], require: 'debug/prelude'
end

group :development do
  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem 'brakeman', '6.2.2', require: false

  # RuboCop is a Ruby code style checking and code formatting tool.
  gem 'rubocop', '1.67.0', require: false
  # Automatic Rails code style checking tool.
  gem 'rubocop-rails', '2.26.2', require: false
  # A collection of RuboCop cops to check for performance optimizations in Ruby code.
  gem 'rubocop-performance', '1.22.1', require: false
end
