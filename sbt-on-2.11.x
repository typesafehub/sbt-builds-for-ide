# Warning: THIS FILE IS USED IN PR VALIDATION. DO NOT MODIFY WITHOUT
#          NOTIFYING SCALA, SCALA-IDE TEAMS
# Nightly job: https://jenkins-dbuild.typesafe.com:8499/job/sbt-nightly-for-ide-on-scala-2.11.x/
{
  properties: "file://"${PWD}"/versions.properties"
  // Variables that may be external.  We have the defaults here.
  vars: {
    publish-repo: "http://private-repo.typesafe.com/typesafe/ide-2.11"
    publish-repo: ${?PUBLISH_REPO}
    sbt.version.suffix: "-for-IDE"
    sbt.branch.prefix: ""
    zinc.gitref: "v0.3.0"
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
      },
      {
        name: scalacheck
        extra.sbt-version: "0.13.0",
        uri: "https://github.com/rickynils/scalacheck.git#1.11.1"
      },
      {
        name:   "sbinary",
        extra.sbt-version: "0.13.0",
        uri:    "git://github.com/harrah/sbinary.git#2.11"
      }, {
        name:   "sbt",
        uri:    "git://github.com/sbt/sbt.git#0.13-2.11"
        extra: {
          sbt-version: "0.12.4",
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
        set-version: "0.13.0"${vars.sbt.branch.prefix}"-on-"${vars.maven.version.number}${vars.sbt.version.suffix}"-SNAPSHOT"
      }, {
        name:   "zinc",
        uri:    "https://github.com/typesafehub/zinc.git#"${vars.zinc.gitref}
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


// {
//   name:  "scala-compiler-doc",
//   system: "ivy",
//   set-version: ${vars.scala-compiler-doc.version.number}
//   uri:    "ivy:org.scala-lang.modules#scala-compiler-doc_"${vars.scala.binary.version}";"${vars.scala-compiler-doc.version.number}
// }, {
//   name:  "scala-compiler-interactive",
//   system: "ivy",
//   set-version: ${vars.scala-compiler-interactive.version.number}
//   uri:    "ivy:org.scala-lang.modules#scala-compiler-interactive_"${vars.scala.binary.version}";"${vars.scala-compiler-interactive.version.number}
// },
