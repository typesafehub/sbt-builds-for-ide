{
  // Variables that may be external.  We have the defaults here.
  globals: {
    scala-version: "2.11.0-SNAPSHOT"
    scala-version: ${?SCALA_VERSION}
    scala-binary-version: "2.11.0-M4"
    scala-binary-version: ${?SCALA_BINARY_VERSION}
    publish-repo: "http://private-repo.typesafe.com/typesafe/ide-2.11"
    publish-repo: ${?PUBLISH_REPO}
  }
  build: {
    "projects":[
      {
        name:  "scala-xml",
        system: "ivy",
        uri:    "ivy:org.scala-lang.modules#scala-xml_2.11.0-M4;1.0-RC3"
        set-version: "1.0-RC3"
      }, {
        name:  "scala-parser-combinators",
        system: "ivy",
        uri:    "ivy:org.scala-lang.modules#scala-parser-combinators_2.11.0-M4;1.0-RC1",
        set-version: "1.0-RC1"
      }, {
        name:  "scala-lib",
        system: "ivy",
        set-version: ${globals.scala-version}
        uri:    "ivy:org.scala-lang#scala-library;"${globals.scala-version}
      }, {
        name:  "scala-compiler",
        system: "ivy",
        set-version: ${globals.scala-version}
        uri:    "ivy:org.scala-lang#scala-compiler;"${globals.scala-version}
      }, {
        name:  "scala-actors",
        system: "ivy",
        uri:    "ivy:org.scala-lang#scala-actors;"${globals.scala-version}
        set-version: ${globals.scala-version}
      }, {
        name:  "scala-reflect",
        system: "ivy",
        uri:    "ivy:org.scala-lang#scala-reflect;"${globals.scala-version}
        set-version: ${globals.scala-version}
      }, {
        name:   "sbinary",
        uri:    "git://github.com/harrah/sbinary.git#2.11"
        extra: {
          projects: ["core"],
          run-tests: false // Sbinary has some invalid case classes currently.
        }
      }, {
        name:   "sbt",
        uri:    "git://github.com/sbt/sbt.git#0.13-2.11"
        extra: {
          projects: ["compiler-interface",
                     "classpath","logging","io","control","classfile",
                     "process","relation","interface","persist","api",
                     "compiler-integration","incremental-compiler","compile","launcher-interface"
                    ],
          run-tests: false,
          commands: [ "set every Util.includeTestDependencies := false" // Without this, we have to build specs2
                    ]
        }
      }, {
        name:   "sbt-republish",
        uri:    "http://github.com/typesafehub/sbt-republish.git#master",
        set-version: "0.13.0-on-"${globals.scala-version}"-for-IDE-SNAPSHOT"
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
        uri=${?globals.publish-repo},
        credentials="/home/jenkinsdbuild/dbuild-josh-credentials.properties",
        projects:["sbt-republish"]
      }
    ]
    notifications: {
      send:{
        projects: "."
        send.to: "qbranch@typesafe.com"
        when: bad
      }
      default.send: {
        from: "jenkins-dbuild <antonio.cunei@typesafe.com>"
        smtp:{
          server: "psemail.epfl.ch"
          encryption: none
        }
      }
    }
  }
}
