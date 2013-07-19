{"projects":[
  {
    name:  "scala",
    system: "scala",
    uri:    "git://github.com/scala/scala.git#master",
    set-version: "2.11.0-SNAPSHOT"  // This version should be the one the ide is using/building.
  }, {
    name:   "scalacheck",
    uri:    "git://github.com/jsuereth/scalacheck.git#wip-jsuereth-1.10-on-scala-2.11"   // PR submitted to rickynils/scalacheck
  }, {
    name:   "sbinary",
    uri:    "git://github.com/harrah/sbinary.git"
    extra: {
      projects: ["core"],
      run-tests: false  // Sbinary has some invalid case classes currently.
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
      commands: [ "set every Util.includeTestDependencies := false" ]  // Without this, we have to build specs2
    }
  }, {
    name:   "sbt-republish",
    uri:    "http://github.com/typesafehub/sbt-republish.git#master",
    set-version: "0.13.0-on-2.11.x-for-IDE-SNAPSHOT"   // This is the version you want to depend on.
  }, {
    name:   "scalaz",
    uri:    "git://github.com/jsuereth/scalaz.git#wip-scalaz-seven-scala-2.11"
    extra: {
      projects: [ "core", "concurrent" ]
    }
  },{
    name:   "specs2",
    uri: "git://github.com/etorreborre/specs2.git"
    // one test is currently failing
    extra: { run-tests: false }
  }
],
deploy: [
  {
    uri="file:///home/jsuereth/test-repo"    // This should be the repo for the ide.
    projects:["sbt-republish"]
  }
  ]
}
