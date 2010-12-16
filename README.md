RubyOnAkka
==============

Small experiment of using [akka](http://akkasource.org/) with [JRuby](http://jruby.org/).


Running
----
Just clone the repository, and execute rake run (or just rake, as it is the default task).
Since all akka, scala and jar
dependencies are bundled in the vendor directory, you just need JRuby 1.5.6 (older versions
had problems with scala artifacts).

To run other experiments just pass an argument to the rake task (rake -D run for more info).

**Java Equivalent** For performance comparisons, a java version is also


Meta
----

Created by Daniel Ribeiro

Released under the MIT License: http://www.opensource.org/licenses/mit-license.php

http://github.com/danielribeiro/RubyOnAkka
