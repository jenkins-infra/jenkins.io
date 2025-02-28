source 'https://rubygems.org'

gem 'colorize'
gem 'base64' # needed since ruby 3.4 https://github.com/igrigorik/em-websocket/pull/161
gem 'awestruct', '~> 0.6.7'
gem 'naturally', '~> 2.2.1'
gem 'asciidoctor', '~> 2.0.18'
gem 'asciidoctor-jenkins-extensions', '~> 0.9.0'
gem 'webrick', '~> 1.8.1'

gem 'sassc'
gem 'rouge'
gem 'iconv'

# Support for various template engines we use
gem 'haml', '~> 5.2.0'
gem 'liquid', '~> 5.5.0'
gem 'kramdown', '~> 2.5.0'

# Gems necessary for running scripts/fetch-external-resources
group :fetcher do
  gem 'faraday', '~> 2.12.0'
  gem 'faraday-follow_redirects', '~> 0.3.0'
  gem 'rubyzip', '~> 2.3.2'
  # dependencies for faraday 2.12.1
  gem 'faraday-net_http', '~> 3.4'
  gem 'json', '~> 2.9'
  gem 'logger', '~> 1.6', '>= 1.6.3'
  gem 'csv', '~> 3.3.2'
end

gem "concurrent-ruby", "~> 1.1"

# for releases.rss.ruby
gem 'rss'
