require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'rake/testtask'
require 'spec/rake/spectask'

def jruby_execute(filename = nil, args = [])
  vendorFiles = [''] + %w[akka_2.8.0-0.10.jar akka-core_2.8.0-0.10.jar scala-library.jar]
  ENV['CLASSPATH'] = vendorFiles.map { |v| File.expand_path v, 'vendor' }.join(":")
  filename = "lib/actor_word_count.rb" if filename.nil?
  system 'jruby', *(['-Ilib', filename] + args)
end

task :default => :run
desc "Runs jruby on a file with the correct classpath. By default runs actor_word_cout.
To run other file, like basic_example.rb, just pass the arguemnt:
  $rake run[lib/basic_example.rb]"
task :run, :filename do |t, args|
  jruby_execute args.filename
end


desc "Benchmarks the actors word count.
Receives two arguments: chunkSize and mapActorsCount"
task :benchmark, :chunkSize, :mapActorsCount do |t, args|
  jruby_execute 'lib/benchmarking_akka.rb',
      [args.chunkSize || "200", args.mapActorsCount || "2"]
end
