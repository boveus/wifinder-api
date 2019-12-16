source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'
gem 'rails', '~> 5.2.2'
gem 'sqlite3', '~> 1.4.1'
gem 'puma', '~> 3.12'
gem 'bootsnap', '>= 1.1.0'
gem 'rack-cors', :require => 'rack/cors'
gem 'oui-offline', '~> 1.2.7', git: 'git@github.com:boveus/oui.git'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'pry'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
