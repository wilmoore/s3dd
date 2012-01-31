s3dd: S3 directory dumper script with parallel execution
========================================================

This utility was written to address the needs of those needing to quickly get a LOT of files into an S3 bucket. The S3cmd utility is great; however, there is no built-in functionality that will load files in parallel.


Usage Examples
--------------

**Basic Usage**

    % s3dd ~/images/client/logos client-logos-bucket

**Advanced Usage (passing additional 'xargs' parameters)**

>   this has not yet been implemented (I am happy to receive pull requests :)

    % s3dd ~/images/client/logos client-logos-bucket -P40


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

    % brew install --HEAD https://raw.github.com/gist/1636830/s3dd.rb


Directories
------------

>   s3 does not have true directories in the typical sense; however, directories can be simulated by creating a zero-length file with content type
>   "binary/octet-stream". It is also recommended to append a "/" to the object name/key. This is not required, but will make your life easier.

`s3dd` includes another tool called `s3mkdirs` which scans a top-level directory and mirrors the directory structure to the given s3 bucket.

**Invoking**

    % s3mkdirs /mnt/clientlogos client-logos

**DRY RUN (just reports the directories that "WOULD" be created)**

    % DRYRUN=1 s3mkdirs /mnt/clientlogos client-logos

**Logging to a file**

    % s3mkdirs /mnt/clientlogos client-logos 2>&1 | tee /tmp/clientlogos.s3.log

