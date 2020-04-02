let upstream =
      https://github.com/purescript/package-sets/releases/download/psc-0.13.6-20200331/packages.dhall sha256:350af1fdc68c91251138198f03ceedc4f8ed6651ee2af8a2177f87bcd64570d4

let moment =
      https://raw.githubusercontent.com/d0liver/ps-moment/master/spago.dhall sha256:87a0ecbceafe9184fd9918b405bf9ae5215cded728985c014444d9ad428d8e54

let overrides = {=}

let additions =
      { moment =
          { repo = "https://github.com/d0liver/ps-moment"
          , version = "master"
          , dependencies = moment.dependencies
          }
      , unicode-prelude =
          { repo = "https://github.com/vyorkin/purescript-unicode-prelude"
          , version = "v0.2.4"
          , dependencies = [ "prelude" ]
          }
      }

in  upstream // overrides // additions
