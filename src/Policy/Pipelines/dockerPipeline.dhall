let Pipeline = ../../Core/Pipelines/package.dhall

let Env = ./Env.dhall

let Map = https://prelude.dhall-lang.org/Map/Type

let Entry = https://prelude.dhall-lang.org/Map/Entry

let affinityGroup = "aff1"

let buildStepPrefix = "${Env.team}-${Env.imageName}"

let buildStepName = "${buildStepPrefix}-build"

let dockerPipeline
    : List (Entry Text Pipeline.Step)
    = [ { mapKey = buildStepName
        , mapValue =
            Pipeline.Step.DockerBuild
              { conf =
                { affinityGroup = Some affinityGroup
                , priority = None Text
                , timeoutSeconds = None Text
                , nodePool = None Text
                , chronological = None Bool
                , environmentVariables = None (Map Text Text)
                , integrations = [ Env.artifactoryIntegration.name ] : List Text
                , inputSteps = [] : List Text
                , inputResources = [ { name = Env.gitRepo, trigger = True } ]
                , outputResources = [] : List Text
                , runtime = ""
                , dockerFileLocation = ""
                , dockerFileName = "Dockerfile"
                , dockerImageName = Env.gitRepo
                , dockerImageTag = "\${run_number}"
                , dockerOptions = ""
                }
              }
        }
      , { mapKey = "${buildStepPrefix}-publish"
        , mapValue =
            Pipeline.Step.DockerPush
              { conf =
                { affinityGroup = Some affinityGroup
                , priority = None Text
                , timeoutSeconds = None Text
                , nodePool = None Text
                , chronological = None Bool
                , environmentVariables = None (Map Text Text)
                , integrations = [ Env.artifactoryIntegration.name ]
                , inputSteps = [ buildStepName ]
                , inputResources = [] : List { name : Text, trigger : Bool }
                , outputResources = [ "${buildStepPrefix}-buildinfo" ]
                , runtime = ""
                , targetRepository = "TODO:"
                , forceXrayScan = True
                , failOnScan = True
                , autoPublishBuildInfo = True
                }
              }
        }
      ]

in  dockerPipeline
