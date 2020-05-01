let Maturity = ../Maturity/package.dhall

let MaturityType = Maturity.Type

let Package = ../../Core/PackageType/package.dhall

let PackageType = Package.PackageType

in  { localRepoKeyFunc =
          λ(team : Text)
        → λ(tech : PackageType)
        → λ(maturity : MaturityType)
        → "${Package.show tech}-${team}-${Maturity.show maturity}-local"
    , virtualRepoKeyFunc =
        λ(team : Text) → λ(tech : PackageType) → "${Package.show tech}-${team}"
    }
