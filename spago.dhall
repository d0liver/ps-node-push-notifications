{ name = "ps-node-push-notifications"
, dependencies =
  [ "aff-promise"
  , "console"
  , "effect"
  , "foreign-generic"
  , "moment"
  , "node-path"
  , "prelude"
  , "psci-support"
  , "unicode-prelude"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
