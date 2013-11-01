{
  // Variables that may be external.  We have the defaults here.
  vars: {
    scala-version: "2.11.0-SNAPSHOT"
    scala-version: ${?SCALA_VERSION}
    scala-binary-version: "2.11.0-M5"
    scala-binary-version: ${?SCALA_BINARY_VERSION}
    parser-combinator-version: "1.0.0-RC3"
    parser-combinator-version: ${?SCALA_PARSER_COMBINATOR_VERSION}
    xml-version: "1.0.0-RC5"
    xml-version: ${?SCALA_XML_VERSION}
    publish-repo: "http://private-repo.typesafe.com/typesafe/ide-2.11"
    publish-repo: ${?PUBLISH_REPO}
  }
  build: {
    "projects":[
      {
        name:  "scala-xml",
        system: "ivy",
        uri:    "ivy:org.scala-lang.modules#scala-xml_"${vars.scala-binary-version}";"${vars.xml-version}
        set-version: "1.0-RC3"
      }, {
        name:  "scala-parser-combinators",
        system: "ivy",
        uri:    "ivy:org.scala-lang.modules#scala-parser-combinators_"${vars.scala-binary-version}";"${vars.parser-combinator-version},
        set-version: "1.0-RC1"
      }, {
        name:  "scala-lib",
        system: "ivy",
        set-version: ${vars.scala-version}
        uri:    "ivy:org.scala-lang#scala-library;"${vars.scala-version}
      }, {
        name:  "scala-compiler",
        system: "ivy",
        set-version: ${vars.scala-version}
        uri:    "ivy:org.scala-lang#scala-compiler;"${vars.scala-version}
      }, {
        name:  "scala-actors",
        system: "ivy",
        uri:    "ivy:org.scala-lang#scala-actors;"${vars.scala-version}
        set-version: ${vars.scala-version}
      }, {
        name:  "scala-reflect",
        system: "ivy",
        uri:    "ivy:org.scala-lang#scala-reflect;"${vars.scala-version}
        set-version: ${vars.scala-version}
      }, {
        name:   "sbinary",
        uri:    "git://github.com/harrah/sbinary.git#2.11"
        extra: {
          projects: ["core"],
          run-tests: false // Sbinary has some invalid case classes currently.
        }
      }, {
        name:   "sbt",
        uri:    "git://github.com/sbt/sbt.git#0.13"
        extra: {
          projects: ["compiler-interface",
                     "classpath","logging","io","control","classfile",
                     "process","relation","interface","persist","api",
                     "compiler-integration","incremental-compiler","compile","launcher-interface"
                    ],
          run-tests: false,
          sbt-version: "0.13.0",
          commands: [ "set every Util.includeTestDependencies := false" // Without this, we have to build specs2
                    ]
        }
      }, {
        name:   "sbt-republish",
        uri:    "http://github.com/typesafehub/sbt-republish.git#master",
        set-version: "0.13.0-master-on-"${vars.scala-version}"-SNAPSHOT"
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
        uri=${?vars.publish-repo},
        credentials="/home/jenkinsdbuild/dbuild-josh-credentials.properties",
        projects:["sbt-republish"]
      }
    ]
    notifications: {
      send:[{
        projects: "."
        send.to: "qbranch@typesafe.com"
        when: bad
      },{ 
        projects: "."
        kind: console
        when: always
      }]
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
