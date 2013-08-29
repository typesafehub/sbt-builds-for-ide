{
  build: {
    "projects":[
      {
        name:  "scala-lib",
        system: "ivy",
        uri:    "ivy:org.scala-lang#scala-library;2.11.0-SNAPSHOT"
       set-version: "2.11.0-SNAPSHOT"
      }, {
        name:  "scala-compiler",
        system: "ivy",
        uri:    "ivy:org.scala-lang#scala-compiler;2.11.0-SNAPSHOT"
        set-version: "2.11.0-SNAPSHOT"
      }, {
        name:  "scala-actors",
        system: "ivy",
        uri:    "ivy:org.scala-lang#scala-actors;2.11.0-SNAPSHOT"
       set-version: "2.11.0-SNAPSHOT"
      }, {
        name:  "scala-reflect",
        system: "ivy",
        uri:    "ivy:org.scala-lang#scala-reflect;2.11.0-SNAPSHOT"
        set-version: "2.11.0-SNAPSHOT"
      }, {
        name:  "scala-xml",
        system: "ivy",
        uri:    "ivy:org.scala-lang#scala-xml;2.11.0-M4"
        set-version: "2.11.0-SNAPSHOT"
      }, {
        name:  "scala-parser-combinators",
        system: "ivy",
        uri:    "ivy:org.scala-lang#scala-parser-combinators;2.11.0-M4"
        set-version: "2.11.0-SNAPSHOT"
      }, {
        name:   "sbinary",
        uri:    "git://github.com/harrah/sbinary.git"
        extra: {
          projects: ["core"],
          run-tests: false // Sbinary has some invalid case classes currently.
        }
      }, {
        name:   "sbt",
        uri:    "git://github.com/sbt/sbt.git#0.13.0"
        extra: {
          projects: ["compiler-interface",
                     "classpath","logging","io","control","classfile",
                     "process","relation","interface","persist","api",
                     "compiler-integration","incremental-compiler","compile","launcher-interface"
                    ],
          run-tests: false,
          commands: [ "set every Util.includeTestDependencies := false" ] // Without this, we have to build specs2
        }
      }, {
        name:   "sbt-republish",
        uri:    "http://github.com/typesafehub/sbt-republish.git#master",
        set-version: "0.13.0-on-2.11.0-SNAPSHOT-for-IDE-SNAPSHOT"
      }, {
        name:   "zinc",
        uri:    "https://github.com/typesafehub/zinc.git"
      }
    ],
    options:{cross-version:standard},
  }
  options: {
    deploy: [
      {
        uri="http://private-repo.typesafe.com/typesafe/ide-2.11",
        credentials="/home/jenkinsdbuild/dbuild-josh-credentials.properties",
        projects:["sbt-republish"]
      }
    ]
  }
}
