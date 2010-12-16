require 'java'
module Akka
  include_package 'se.scalablesolutions.akka.actor'
end

module Actors
  class Base < Akka::UntypedActor
    def self.create(*args)
      self.new(*args)
    end

    def self.build(*args)
      return Akka::UntypedActor.actorOf(self)  if args.empty?
      Akka::UntypedActor.actorOf { self.new(*args) }
    end

    def self.spawn(*args)
      build(*args).start
    end
  end

  # Actor that is initialized with onReceive block.
  class BlockActor < Base
    def self.new(block)
      ret = super()
      ret.instance_variable_set(:@_block, block)
      return ret
    end

    def onReceive(message)
      instance_exec message, &@_block
    end
  end

  class DelegatorActor < Base
    def self.new(target)
      ret = super()
      ret.instance_variable_set(:@target, target)
      return ret
    end

    def onReceive(message)
      param = message
      @target.__send__ param.name, *param.args, &param.block
    end
  end

  MethodParameters = Struct.new :name, :args, :block

  # Used to adapt method calls to actor message sending (using sendOneWay).
  # Used in combinatrion with DelegatorActor. See more in actorOf method
  class ActorRefHandler
    public_instance_methods.each do |m|
      undef_method m unless m =~ /^__/ or m == 'to_s'
    end

    def initialize(actorRef)
      @actorRef = actorRef
    end

    def method_missing(name, *args, &block)
      @actorRef.sendOneWay MethodParameters.new name, args, block
    end
  end



  extend self
  def spawn(&block)
    BlockActor.spawn block
  end

  def actor(&block)
    BlockActor.build block
  end

  def actorOf(object)
    ActorRefHandler.new DelegatorActor.spawn object
  end
  
end
