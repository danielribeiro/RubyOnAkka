require 'akka'
require 'regular_word_count'
include Actors
module AkkaDispatcher
  include_package 'se.scalablesolutions.akka.dispatch'
  def self.workStealer(name)
    Dispatchers.newExecutorBasedEventDrivenWorkStealingDispatcher 'mappers'
  end
end

file = File.join(File.dirname(__FILE__), 'shakespeare.txt')
input = IO.readlines(file).each_slice(500).map &:join

start = nil
values = Hash.new 0
linesToRead = input.size
reduceActor = actor do |message|
  linesToRead -= 1
  hash = message
  hash.each do |key, value|
    values[key] += value
  end
  if linesToRead == 0
    puts ">> All over: Just to say we used any computed value: #{values['shakespeare']}"
    finish = Time.now
    puts ">> Total time: #{finish - start}s"
    Akka::ActorRegistry.shutdownAll()
  end
end

mapActorsSize = 2
mapActors = []
wordCount = WordCount.new
workStealer = AkkaDispatcher.workStealer 'mappers'
mapActorsSize.times do
  mapActor = actor do |message|
    reduceActor.sendOneWay wordCount.count message
  end
  mapActor.setDispatcher workStealer
  mapActors.push mapActor
end

mapActor = mapActors.first
producer = actor do |message|
  for line in input
    mapActor.sendOneWay line
  end
end

allActors = [reduceActor, producer] + mapActors
allActors.each do |a|
  a.start
end
start = Time.now
producer.sendOneWay :start
