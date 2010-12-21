#!/bin/bash
CLASSPATH=./vendor:./vendor/akka_2.8.0-0.10.jar:./vendor/akka-core_2.8.0-0.10.jar:./vendor/scala-library.jar jruby -Ilib lib/benchmarking_akka.rb $1 $2
