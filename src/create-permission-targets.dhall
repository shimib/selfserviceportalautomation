let MaturityType = ./Policy/Maturity/package.dhall

let Maturity = MaturityType.Type

let Package = ./Core/PackageType/package.dhall

let PackageType = Package.PackageType

let RoleType = ./Policy/Role/package.dhall

let Role = RoleType.Type

let PermissionTargetType = ./Core/Permission/package.dhall

let Action = PermissionTargetType.Action

let RepoPermissions = PermissionTargetType.RepoPermissions

let maturityRolePermissions = ./Policy/Permissions/maturityRolePermissions.dhall

let RepoKeys = ./Policy/Repo/package.dhall

let Map = https://prelude.dhall-lang.org/Map/package.dhall

let Entry = Map.Entry

let map = https://prelude.dhall-lang.org/List/map

let concatSep = https://prelude.dhall-lang.org/Text/concatSep

let toJSONArrText = ./Core/Utils/toJSONArrText.dhall

let ActionsForRole = { role : Role, actions : List Action }

let Env = ./Policy/Env.dhall

let team = env:TEAM as Text

let permissionTargetNameFunc =
      λ(team : Text) → λ(m : Maturity) → "${team}-${MaturityType.show m}"

let repoPermission =
        λ(m : Maturity)
      → let repositories
            : List Text
            = map
                PackageType
                Text
                (λ(tech : PackageType) → RepoKeys.localRepoKeyFunc team tech m)
                Env.packages

        let actionsPerRole = maturityRolePermissions m

        let actionsPerGroup =
              map
                ActionsForRole
                (Entry Text (List Action))
                (   λ(e : ActionsForRole)
                  → let role = e.role

                    let value = e.actions

                    in  { mapKey = RoleType.toGroupName role team
                        , mapValue = value
                        }
                )
                actionsPerRole

        in  RepoPermissions::{
            , repositories = repositories
            , actions =
              { users = Map.empty Text (List Action), groups = actionsPerGroup }
            }

let permissionRecord
    : Entry Text (List Action) → Text
    =   λ(e : Entry Text (List Action))
      → ''
         "${e.mapKey}" : ${toJSONArrText
                             ( map
                                 Action
                                 Text
                                 PermissionTargetType.actionShow
                                 e.mapValue
                             )} 
        ''

let repoPermissionTemplate =
        λ(rp : RepoPermissions.Type)
      → ''
         {
           "include-patterns": ${toJSONArrText rp.includesPatterns},
           "exclude-patterns": ${toJSONArrText rp.excludesPatterns},
           "repositories": ${toJSONArrText rp.repositories},
           "actions": {
             "groups": {
                ${concatSep
                    ","
                    ( map
                        (Entry Text (List Action))
                        Text
                        permissionRecord
                        rp.actions.groups
                    )}
             } 
            }
          } 
        ''

let permissionTargetTemplate =
        λ(pt : RepoPermissions.Type)
      → λ(name : Text)
      → Map.keyValue
          Text
          "${name}.permissiontarget"
          ''
           {
             "name": "${name}",
             "repo": ${repoPermissionTemplate pt}  
           } 
          ''

let mainFunc =
        λ(m : Maturity)
      → permissionTargetTemplate
          (repoPermission m)
          (permissionTargetNameFunc team m)

in  map Maturity (Entry Text Text) mainFunc MaturityType.all
