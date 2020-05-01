let Pipelines = ./Core/Pipelines/package.dhall

let Package = ./Core/PackageType/package.dhall

let map = https://prelude.dhall-lang.org/Optional/map

let Entry = https://prelude.dhall-lang.org/Map/Entry

let dockerPipeline = ./Policy/Pipelines/dockerPipeline.dhall

let PackageType = Package.PackageType

let Env = ./Policy/Env.dhall

let project = "mysql-docker"

let team = Env.team

let pipelineName = "${team}-${project}"

let Content = List (Entry Text Pipelines.Step)

let pipelineByPackageType
    : PackageType → Optional Pipelines.Pipeline
    =   λ(tech : PackageType)
      → map
          Content
          Pipelines.Pipeline
          (λ(content : Content) → { name = pipelineName, steps = content })
          ( merge
              { docker = Some dockerPipeline
              , maven = None Content
              , opkg = None Content
              , cocoapods = None Content
              , ivy = None Content
              , puppet = None Content
              , generic = None Content
              , sbt = None Content
              , npm = None Content
              , gitlfs = None Content
              , pypi = None Content
              , gradle = None Content
              , helm = None Content
              , go = None Content
              , cran = None Content
              , gems = None Content
              , bower = None Content
              , composer = None Content
              , vagrant = None Content
              , chef = None Content
              , debian = None Content
              , rpm = None Content
              , yum = None Content
              , conan = None Content
              , nuget = None Content
              }
              tech
          )

in  pipelineByPackageType PackageType.docker
