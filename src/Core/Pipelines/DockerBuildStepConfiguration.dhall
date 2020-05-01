-- Note: we are not enforcing values here as to inherit fields from Bash..Configuration.
-- Validation should be done in layers using this type.

let BashStepConfiguration = ./BashStepConfiguration.dhall

let DockerBuildStepConfiguration =
        BashStepConfiguration
      ⩓ { dockerFileLocation : Text
        , dockerFileName : Text
        , dockerImageName : Text
        , dockerImageTag : Text
        , dockerOptions : Text
        }

in  DockerBuildStepConfiguration
