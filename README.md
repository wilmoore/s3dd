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


>   this has not yet been implemented (I am happy to receive pull requests :)


    $ s3dd ~/images/client/logos client-logos-bucket -P40


Requirements
------------

*   [required] s3cmd, xargs
*   [required] grep, sort, find, cut (should we just use Ruby, Python, or Perl instead?)


Installing
----------

**Git**

    % mkdir -p $HOME/local
    % cd !$
    % git clone https://github.com/Net-Results/s3dd.git
    % chmod a+x bin/*

**cURL**

    % mkdir -p $HOME/local/s3dd   # this location is configurable, just don't forget to add this to your search path (or symlink to your 'bin' directory)
    % cd !$
    % curl -# -L https://github.com/Net-Results/s3dd/tarball/master | tar -xz --strip 1
    % chmod a+x bin/*

**Homebrew:**

    $ brew install --HEAD https://raw.github.com/gist/1636830/s3dd.rb


Alternatives
------------

- GNU Parallel (+ s3cmd)

