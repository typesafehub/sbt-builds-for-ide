# Warning: THIS FILE IS BEING USED FOR INTEGRATION WITH THE SCALA-IDE TEAM
#          Pleases do not modify without contacting them.
# Nighlty job: https://jenkins-dbuild.typesafe.com:8499/job/sbt-0.13.x-nightly-for-ide-on-scala-2.10.x
{
  properties: "file://"${PWD}"/versions.properties"
  // Variables that may be external.  We have the defaults here.
  vars: {
    scala-version: "2.11.0-SNAPSHOT"
    scala-version: ${?SCALA_VERSION}
    publish-repo: "http://private-repo.typesafe.com/typesafe/ide-2.11"
    publish-repo: ${?PUBLISH_REPO}
    sbt-version: "0.13.2-M1"
    sbt-version: ${?SBT_VERSION}
    sbt-tag: "v"${vars.sbt-version}
    sbt-tag: ${?SBT_TAG}
  }
  build: {
    "projects":[
       {
        system: assemble
        name:   scala2
        deps.ignore: "org.scalacheck#scalacheck"
        extra.parts.options: {
          cross-version: standard
          sbt-version: "0.13.0"
        }
        extra.parts.projects: [
          {
            name:  "scala-lib",
            system: "ivy",
            set-version: ${vars.maven.version.number}
            uri:    "ivy:org.scala-lang#scala-library;"${vars.maven.version.number}
          }, {
            name:  "scala-reflect",
            system: "ivy",
            uri:    "ivy:org.scala-lang#scala-reflect;"${vars.maven.version.number}
            set-version: ${vars.maven.version.number}
          }, {
            name:  "scala-compiler",
            system: "ivy",
            set-version: ${vars.maven.version.number}
            uri:    "ivy:org.scala-lang#scala-compiler;"${vars.maven.version.number}
          },
          {
            name:  "scala-xml",
            system: "ivy",
            uri:    "ivy:org.scala-lang.modules#scala-xml_"${vars.scala.binary.version}";"${vars.scala-xml.version.number}
            set-version: "1.0-RC3" // required by sbinary?
          }, {
            name:  "scala-parser-combinators",
            system: "ivy",
            uri:    "ivy:org.scala-lang.modules#scala-parser-combinators_"${vars.scala.binary.version}";"${vars.scala-parser-combinators.version.number},
            set-version: "1.0-RC1" // required by sbinary?
          }
        ]
      }, {
        name: scalacheck
        extra.sbt-version: "0.13.0",
        uri: "https://github.com/rickynils/scalacheck.git#1.11.1"
      }, {
        name:   "sbinary",
        uri:    "git://github.com/harrah/sbinary.git#master"
        extra: { projects: ["core"] }
      }, {
        name:   "sbt",
        uri:    "git://github.com/sbt/sbt.git#"${vars.sbt-tag}
        extra: {
          projects: ["compiler-interface",
                     "classpath","logging","io","control","classfile",
                     "process","relation","interface","persist","api",
                     "compiler-integration","incremental-compiler","compile","launcher-interface"
                    ],
          run-tests: false,
          sbt-version: "0.13.1"
        }
      }, {
        name:   "sbt-republish",
        uri:    "http://github.com/typesafehub/sbt-republish.git#master",
        set-version: ${vars.sbt-version}"-on-"${vars.scala-version}"-for-IDE-SNAPSHOT"
      }, {
        name:   "zinc",
        uri:    "https://github.com/typesafehub/zinc.git#master"
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
