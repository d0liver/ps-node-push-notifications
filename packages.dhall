let upstream =
  https://github.com/purescript/package-sets/releases/download/psc-0.13.6-20200331/packages.dhall sha256:350af1fdc68c91251138198f03ceedc4f8ed6651ee2af8a2177f87bcd64570d4

let overrides = {=}

let additions =
  { moment =
    { repo = "https://github.com/d0liver/ps-moment.git"
    , version = "a73195309fade58e75a3bb01ec19a2803f06ea08"
    , dependencies = [ "console", "effect", "js-date", "psci-support", "spec", "unicode-prelude" ]
    }
  , unicode-prelude =
    { dependencies =
        [ "prelude" ]
    , repo =
        "https://github.com/vyorkin/purescript-unicode-prelude"
    , version =
        "v0.2.4"
    }
}

in  upstream // overrides // additions
