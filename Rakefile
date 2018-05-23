begin
  require 'bundler'
rescue LoadError
  puts 'Failed to load bundler, try running: gem install bundler'
  exit 1
end

begin
  require 'rubygems'
rescue LoadError
  puts 'Failed to load some dependencies, try running: bundle install'
  exit 1
end

desc 'Clean Run :)'
task default: %w[run]

desc 'Install gems dependencies'
task :install do
  exec('bundle install')
end

desc 'Run some tests'
task :test do
  # ruby 'lib/bot.rb'
end

desc 'Run GL_BaseCamp Bot'
task :run do
  ruby 'lib/bot.rb'
end

desc 'Find out if Bot is still running, kill it.'
task :clean do
  # TODO: make with system if then else ?
  exec("kill $(ps aux | grep '[l]ib/bot.rb' | awk '{print $2}')")
end

# desc 'Example of a task with prerequisites'
# task(third_task: %w[first_task second_task]) do
#   # Your code goes here
# end
