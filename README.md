s3dd: S3 directory dumper script with parallel execution
========================================================


Enumerates a directory of directories and syncs them to S3.


Summary
-------

This utility was written to address the needs of those needing to quickly get a LOT of files into an S3 bucket. The S3cmd utility is great; however, there is no built-in functionality that will load files in parallel.


Usage Examples
--------------

**Basic Usage**

    $ s3dd ~/images/client/logos client-logos-bucket

**Advanced Usage (passing additional 'xargs' parameters)**

    $ s3dd ~/images/client/logos client-logos-bucket -P40 # NOTE: this has not yet been implemented (I am happy to receive pull requests :)


Requirements
------------

*   [required] s3cmd, xargs
*   [required] grep, sort, find, cut (should we just use Ruby, Python, or Perl instead?)


Installing
----------

**Homebrew:**

    $ brew install --HEAD https://raw.github.com/gist/1636830/s3dd.rb

**Manually (assumes $HOME/local/bin, but you can change it to anything in your search path):**

    $ wget -c https://raw.github.com/Net-Results/s3dd/master/s3dd -O $HOME/local/bin/s3dd
    $ chmod a+x !$
    $ which s3dd


Alternatives
------------

- GNU Parallel

