let UsersGroupsActions = ./UsersGroupsActions.dhall

let RepoPermissions = ./RepoPermissions.dhall

let BuildPermission =
      { Type =
          { includesPattern : Text
          , excludesPattern : Text
          , repositories : List Text
          , actions : UsersGroupsActions
          }
      , default =
        { includesPattern = ""
        , excludesPattern = ""
        , repositories = [ "artifactory-build-info" ]
        , actions = None UsersGroupsActions
        }
      }

let ReleaseBundlePermission =
      { Type =
          { includesPattern : Text
          , excludesPattern : Text
          , repositories : List Text
          , actions : UsersGroupsActions
          }
      , default =
        { includesPattern = "**"
        , excludesPattern = ""
        , repositories = [ "release-bundles" ]
        , actions = None UsersGroupsActions
        }
      }

let PermissionTarget =
      { Type =
          { name : Text
          , repo : Optional RepoPermissions.Type
          , build : Optional BuildPermission.Type
          , releaseBundle : Optional ReleaseBundlePermission.Type
          }
      , default =
        { repo = None RepoPermissions.Type
        , build = None BuildPermission.Type
        , releaseBundle = None ReleaseBundlePermission.Type
        }
      }

in  PermissionTarget
