let PackageType = ./PackageType.dhall

let show =
        λ(p : PackageType)
      → merge
          { maven = "maven"
          , gradle = "gradle"
          , ivy = "ivy"
          , sbt = "sbt"
          , helm = "helm"
          , rpm = "rpm"
          , nuget = "nuget"
          , cran = "cran"
          , gems = "gems"
          , npm = "npm"
          , bower = "bower"
          , debian = "debian"
          , pypi = "pypi"
          , docker = "docker"
          , gitlfs = "gitlfs"
          , go = "go"
          , yum = "yum"
          , conan = "conan"
          , chef = "chef"
          , puppet = "puppet"
          , generic = "generic"
          , cocoapods = "cocoapods"
          , opkg = "opkg"
          , composer = "composer"
          , vagrant = "vagrant"
          }
          p

in  show
