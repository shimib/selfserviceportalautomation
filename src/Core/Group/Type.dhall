let Group =
      { Type =
          { name : Text
          , description : Optional Text
          , autoJoin : Bool
          , adminPriviledges : Bool
          , realm : Optional Text
          , realmAttributes : Optional Text
          , userNames : List Text
          , watchManager : Bool
          , policyManager : Bool
          }
      , default =
        { description = None Text
        , autoJoin = False
        , adminPriviledges = False
        , realm = None Text
        , realmAttributes = None Text
        , userNames = [] : List Text
        , watchManager = False
        , policyManager = False
        }
      }

in  Group
