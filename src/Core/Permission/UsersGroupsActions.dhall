let Action = ./Action.dhall

let MapType = https://prelude.dhall-lang.org/Map/package.dhall

let Map = MapType.Type

let UsersGroupsActions =
      { users : Map Text (List Action), groups : Map Text (List Action) }

in  UsersGroupsActions
