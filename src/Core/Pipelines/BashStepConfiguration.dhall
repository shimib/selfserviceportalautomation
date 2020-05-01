let Map = https://prelude.dhall-lang.org/Map/Type

let BashStepConfiguration =
      { affinityGroup : Optional Text
      , priority : Optional Text
      , timeoutSeconds : Optional Text
      , nodePool : Optional Text
      , chronological : Optional Bool
      , environmentVariables : Optional (Map Text Text)
      , integrations : List Text
      , inputSteps : List Text
      , inputResources : List { name : Text, trigger : Bool }
      , outputResources : List Text
      , runtime : Text
      }

in  BashStepConfiguration
