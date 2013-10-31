# SBT builds for IDE

This will create builds of sbt against various "ecosystems" of Scala and release stand-alone-ish maven artifacts for consumption.


## Building

Simply run:

    ./bin/dbuild sbt-on-2.10.x


This will create a bunch of files, and a repository in:

    /tmp/repo-for-sbt-on-2.10.x/

which contains all artifacts.

*Note: Only runs on linux/macosx*

## Layout of builds.

The builds inside of this project are split into two styles:

* `sbt-on-<scala-version>`:
   These builds are against *stable* sbt/zinc branches and *unstable* scala artifacts (`-SNAPSHOT`).  These are built primarily for
   integration with the IDE and the scala pr-validator.  These builds must always be stable, or we start holding up
   both the Scala and the Scala IDE projects.
* `sbt-all-nightly-on-<scala-version>`:
   These builds are against *unstable* sbt/zinc branches and *unstable* scala artifacts (`-SNAPSHOT`).  These are built primarily for
   the sbt/zinc teams to ensure that their integration is up-to-snuff leading to a release.


*TODO:  We should add a new sbt-nightly-on-<stable-scala> integration build which ensures we can build sbt/zinc against stable scala.*
