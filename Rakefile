require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'rake/testtask'
require 'spec/rake/spectask'

task :default => :run
desc "Runs jruby on a file with the correct classpath. By default runs actor_word_cout.
To run other file, like basic_example.rb, just pass the arguemnt:
  $rake run[lib/basic_example.rb]"
task :run, :filename do |t, args|
  vendorFiles = [''] + %w[akka_2.8.0-0.10.jar akka-core_2.8.0-0.10.jar scala-library.jar]
  ENV['CLASSPATH'] = vendorFiles.map { |v| File.expand_path v, 'vendor' }.join(":")
  filename = args.filename
  filename = "lib/actor_word_count.rb" if filename.nil?
  system 'jruby', '-Ilib', filename
end
