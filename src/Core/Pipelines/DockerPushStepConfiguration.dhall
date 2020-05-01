-- Note: we are not enforcing values here as to inherit fields from Bash..Configuration.
-- Validation should be done in layers using this type.

let BashStepConfiguration = ./BashStepConfiguration.dhall

let DockerPushStepConfiguration =
        BashStepConfiguration
      ⩓ { targetRepository : Text
        , forceXrayScan : Bool
        , failOnScan : Bool
        , autoPublishBuildInfo : Bool
        }

in  DockerPushStepConfiguration
