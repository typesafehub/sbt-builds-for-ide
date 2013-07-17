# SBT builds for IDE

This will create builds of sbt against various "ecosystems" of Scala and release stand-alone-ish maven artifacts for consumption.


## Building

Simply run:

    ./bin/dbuild sbt-on-2.10.x


This will create a bunch of files, and a repository in:

    /tmp/repo-for-sbt-on-2.10.x/

which contains all artifacts.


*Note: Only runs on linux/macosx*
