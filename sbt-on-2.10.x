{"projects":[
  {
    name:  "scala",
    system: "scala",
    uri:    "git://github.com/scala/scala.git#v2.10.2",
    set-version: "2.10.2"
  }, {
    name:   "scalacheck",
    uri:    "git://github.com/rickynils/scalacheck.git#1.10.1"
  }, {
    name:   "sbinary",
    uri:    "git://github.com/harrah/sbinary.git"
    extra: { projects: ["core"] }
  }, {
    name:   "sbt",
    uri:    "git://github.com/sbt/sbt.git#0.13"
    extra: {
      projects: ["compiler-interface",
                 "classpath","logging","io","control","classfile",
                 "process","relation","interface","persist","api",
                 "compiler-integration","incremental-compiler","compile","launcher-interface"
                ],
      run-tests: false
    }
  }, {
    name:   "sbt-republish",
    uri:    "http://github.com/typesafehub/sbt-republish.git#master",
    set-version: "0.13.0-on-2.10.x-for-IDE-SNAPSHOT"
  }, {
    name:   "zinc",
    uri:    "https://github.com/typesafehub/zinc.git"
  }
],
deploy: [
  {
    uri="http://private-repo.typesafe.com/typesafe/ide-2.10",
    credentials="/opt/jenkins/credentials.properties",
    projects:["sbt-republish"]
  }
  ]
}
