require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'rake/testtask'
require 'spec/rake/spectask'

def classpath
  vendorFiles = [''] + %w[akka_2.8.0-0.10.jar akka-core_2.8.0-0.10.jar scala-library.jar]
  vendorFiles.map { |v| File.expand_path v, 'vendor' }.join(":")
end

def jruby_execute(filename = nil, args = [])
  ENV['CLASSPATH'] = classpath
  filename = "lib/actor_word_count.rb" if filename.nil?
  puts ENV['CLASSPATH']
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

desc "Generates runner script appropriate for the current machine.
For users using jruby rake"
task :genrunner do
  puts "Generating runner.sh"
  filename = "lib/actor_word_count.rb" if filename.nil?
  File.open("runner.sh", 'w') do |f|
    f.write <<-eof
#!/bin/bash
CLASSPATH=#{classpath} jruby -Ilib $1
eof
  end
  File.chmod 0755, "runner.sh"
  puts "runner.sh created!"
end

desc "Generates a benchmark script appropriate for the current machine.
For users using jruby rake"
task :genbenchmark do
  puts "Generating benchmark.sh"
  filename = "lib/actor_word_count.rb" if filename.nil?
  File.open("benchmark.sh", 'w') do |f|
    f.write <<-eof
#!/bin/bash
CLASSPATH=#{classpath} jruby -Ilib #{file} $1 $2
eof
  end
  File.chmod 0755, "benchmark.sh"
  puts "benchmark.sh created!"
end