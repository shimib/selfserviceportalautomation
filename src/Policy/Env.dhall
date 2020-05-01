let Maturity = ./Maturity/package.dhall

let Package = ../Core/PackageType/package.dhall

let PackageType = Package.PackageType

let Env =
      { maturities = Maturity.all
      , packages = [ PackageType.docker, PackageType.npm, PackageType.generic ]
      , team = env:TEAM as Text
      }

in  Env
