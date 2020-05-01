let UsersGroupsActions = ./UsersGroupsActions.dhall

let RepoPermissions =
      { Type =
          { includesPatterns : List Text
          , excludesPatterns : List Text
          , repositories : List Text
          , actions : UsersGroupsActions
          }
      , default =
        { includesPatterns = [ "**" ], excludesPatterns = [] : List Text }
      }

in  RepoPermissions
