let ArtifactoryIntegration = ./ArtifactoryIntegration.dhall

let DistributionIntegration = ./DistributionIntegration.dhall

let ResourceType =
      < BuildInfo :
          { sourceArtifactory : ArtifactoryIntegration
          , buildName : Text
          , buildNumber : Natural
          , externalCI : Optional Text
          }
      | ReleaseBundle :
          { sourceDistribution : DistributionIntegration
          , name : Text
          , version : Text
          , isSigned : Optional Bool
          }
      >

in  ResourceType
