// External variables (expected to be set as environment variables before calling dbuild)
// NOTE: There are no defaults.
//
// SCALA_VERSION
// PUBLISH_REPO
//
// TODO:
//   SCALA_BINARY_VERSION
//   SCALA_XML_VERSION
//   SCALA_COMBINATORS_VERSION

{
  build: {
    "projects":[
      {
        name:  "scala-lib",
        system: "ivy",
        uri:    "ivy:org.scala-lang#scala-library;"${SCALA_VERSION}
        set-version: ${SCALA_VERSION}
      }, {
        name:  "scala-compiler",
        system: "ivy",
        uri:    "ivy:org.scala-lang#scala-compiler;"${SCALA_VERSION}
        set-version: ${SCALA_VERSION}
      }, {
        name:  "scala-actors",
        system: "ivy",
        uri:    "ivy:org.scala-lang#scala-actors;"${SCALA_VERSION}
        set-version: ${SCALA_VERSION}
      }, {
        name:  "scala-reflect",
        system: "ivy",
        uri:    "ivy:org.scala-lang#scala-reflect;"${SCALA_VERSION}
        set-version: ${SCALA_VERSION}
      }, {
        name:  "scala-xml",
        system: "ivy",
        uri:    "ivy:org.scala-lang#scala-xml;"${SCALA_VERSION}
        set-version: ${SCALA_VERSION}
      }, {
        name:  "scala-parser-combinators",
        system: "ivy",
        uri:    "ivy:org.scala-lang#scala-parser-combinators;"${SCALA_VERSION}
        set-version: ${SCALA_VERSION}
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
        set-version: "0.13.0-on-"${SCALA_VERSION}"-for-IDE-SNAPSHOT"
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
        uri=${?PUBLISH_REPO},
        credentials="/home/jenkinsdbuild/dbuild-josh-credentials.properties",
        projects:["sbt-republish"]
      }
    ]
  }
}
