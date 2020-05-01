let MvnBuildStepConfiguration =
      { mvnCommand : Text
      , sourceLocation : Text
      , configLocation : Text
      , configFileName : Text
      , forceXrayScan : Optional Text
      , failOnScan : Bool
      , autoPublishBuildInfo : Optional Text
      , integrations : List Text
      , inputResources : List Text
      , outputResources : List Text
      }

in  MvnBuildStepConfiguration
