let Package = ./Core/PackageType/package.dhall

let PackageType = Package.PackageType

let Maturity = ./Policy/Maturity/package.dhall

let MaturityType = Maturity.Type

let Entry = https://prelude.dhall-lang.org/Map/Entry

let keyValue = https://prelude.dhall-lang.org/Map/keyValue

let map = https://prelude.dhall-lang.org/List/map

let concatMap = https://prelude.dhall-lang.org/List/concatMap

let concatSep = https://prelude.dhall-lang.org/Text/concatSep

let RepoKeys = ./Policy/Repo/package.dhall

let Env = ./Policy/Env.dhall

let team = env:TEAM as Text

let defaultDeploymentMaturityForVirtual = MaturityType.dev

let LocalRepoArgs = { key : Text, packageType : PackageType }

let VirtualRepoArgs =
      LocalRepoArgs ⩓ { repositories : List Text, defaultDepRepo : Text }

let localRepoTemplate =
        λ(kp : LocalRepoArgs)
      → let repoText = Package.show kp.packageType

        in  keyValue
              Text
              "${kp.key}.template.local"
              ''
                { 
                   "packageType" : "${repoText}", 
                   "rclass"  : "local", 
                   "description" : "${repoText} repository for ${team}" , 
                   "key" : "${kp.key}"
                 } 
              ''

let virtualRepoTemplate =
        λ(args : VirtualRepoArgs)
      → let repoText = Package.show args.packageType

        let reposArrText = concatSep "," args.repositories

        in  keyValue
              Text
              "${args.key}.template.virtual"
              ''
                 {
                     "key" : "${args.key}",
                     "rclass" : "virtual",
                     "packageType" : "${repoText}",
                     "repositories" : "${reposArrText}",
                     "defaultDeploymentRepo" : "${args.defaultDepRepo}"
                 }
              ''

let localRepoKeysAndPackagesPerTech =
        λ(tech : PackageType)
      → map
          MaturityType
          LocalRepoArgs
          (   λ(maturity : MaturityType)
            → { key = RepoKeys.localRepoKeyFunc team tech maturity
              , packageType = tech
              }
          )
          Maturity.all

let localRepoKeysAndPackages =
      concatMap
        PackageType
        LocalRepoArgs
        localRepoKeysAndPackagesPerTech
        Env.packages

let virtualRepoKeysAndPackages =
      map
        PackageType
        VirtualRepoArgs
        (   λ(tech : PackageType)
          → { key = RepoKeys.virtualRepoKeyFunc team tech
            , packageType = tech
            , repositories =
                map
                  LocalRepoArgs
                  Text
                  (λ(kp : LocalRepoArgs) → kp.key)
                  (localRepoKeysAndPackagesPerTech tech)
            , defaultDepRepo =
                RepoKeys.localRepoKeyFunc
                  team
                  tech
                  defaultDeploymentMaturityForVirtual
            }
        )
        Env.packages

in    map
        LocalRepoArgs
        (Entry Text Text)
        localRepoTemplate
        localRepoKeysAndPackages
    # map
        VirtualRepoArgs
        (Entry Text Text)
        virtualRepoTemplate
        virtualRepoKeysAndPackages
