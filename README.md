Powerhistory
==============

Powerhistory a firefox  extension that enables more powerful queries, including: searching
the content of the urls on the history, and limiting by dates.

**Usage:** From menu Tools -> Power History, and opens a page where you can define
your search options

Known limitations: does not request iframes and frames inside the pages.


Building
----
To build the project, you need [coffeescript](http://jashkenas.github.com/coffee-script/)
at least 0.9.4, ruby (at least 1.8.7) and the zip command line tool (which comes with
most linux distributions)

The default rake task compiles the project and watches for any changes on coffee files.
This requires [watchr](https://github.com/mynyml/watchr) gem.

The actual building process is a simple command *rake package*. It will build the
[xpi](https://developer.mozilla.org/en/extension_packaging) on the pkg folder.


Meta
----

Created by Daniel Ribeiro

Released under the MIT License: http://www.opensource.org/licenses/mit-license.php

http://github.com/danielribeiro/powerhistory
