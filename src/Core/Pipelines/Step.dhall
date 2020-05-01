let DockerBuildStepConfiguration = ./DockerBuildStepConfiguration.dhall

let DockerPushStepConfiguration = ./DockerPushStepConfiguration.dhall

let BashStepConfiguration = ./BashStepConfiguration.dhall

let Step =
      < Bash : { conf : BashStepConfiguration }
      | DockerBuild : { conf : DockerBuildStepConfiguration }
      | PublishBuildInfo
      | DockerPush : { conf : DockerPushStepConfiguration }
      | PromoteBuild
      >

in  Step
