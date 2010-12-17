RubyOnAkka
==============

Small experiment of using [Akka](http://akkasource.org/) with [JRuby](http://jruby.org/).
There is no external deps other than jruby 1.5.6 (older versions
had problems with scala artifacts) and rake.

Only the needed Akka deps are included, but Akka is a big project,
so it may take a while to clone the project.

More info [here](http://metaphysicaldeveloper.wordpress.com/2010/12/16/high-level-concurrency-with-jruby-and-akka-actors/).


**Java Equivalent** For performance comparisons, a java version is also
distributed on java folder.


Running
----
Just clone the repository, and execute rake run (or just rake, as it is the default task).

To run other experiments just pass an argument to the rake task (rake -D run for more info).

Happy Hakkaing.


Meta
----

Created by Daniel Ribeiro

Released under the MIT License: http://www.opensource.org/licenses/mit-license.php

http://github.com/danielribeiro/RubyOnAkka
