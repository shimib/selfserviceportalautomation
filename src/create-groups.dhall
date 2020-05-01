let Group = ./Core/Group/Type.dhall

let RoleType = ./Policy/Role/package.dhall

let map = https://prelude.dhall-lang.org/List/map

let Entry = https://prelude.dhall-lang.org/Map/Entry

let keyValue = https://prelude.dhall-lang.org/Map/keyValue

let team = env:TEAM as Text

let groupByRole
    : RoleType.Type → Group.Type
    =   λ(role : RoleType.Type)
      → let groupName = RoleType.toGroupName role team

        in  Group::{ name = groupName }

let groupToFile =
        λ(group : Group.Type)
      → keyValue
          Text
          "${group.name}.group"
          ''
          {
            "name" : "${group.name}"
          }    
          ''

let groups = map RoleType.Type Group.Type groupByRole RoleType.all

in  map Group.Type (Entry Text Text) groupToFile groups
