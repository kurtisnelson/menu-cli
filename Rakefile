require "bundler/gem_tasks"
require './lib/menu'
task :run => [:install] do
  sh 'bin/menu -v -c waitress payload.apk'
end
