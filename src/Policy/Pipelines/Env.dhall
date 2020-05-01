let Pipelines = ../../Core/Pipelines/package.dhall

let team = env:TEAM as Text

let Env =
      { artifactoryIntegration =
          { name = "ArtifactoryUnified" } : Pipelines.ArtifactoryIntegration
      , gitRepo = "${team}"
      , imageName = "${team}"
      , team = "${team}"
      }

in  Env
