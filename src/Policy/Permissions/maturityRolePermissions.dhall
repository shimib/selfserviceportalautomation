let PermissionTarget = ../../Core/Permission/package.dhall

let RoleType = ../Role/package.dhall

let Role = RoleType.Type

let Maturity = ../Maturity/package.dhall

let Action = PermissionTarget.Action

let ActionsForRole = { role : Role, actions : List Action }

let maturityRolePermissions
    : Maturity.Type → List ActionsForRole
    =   λ(m : Maturity.Type)
      → merge
          { dev =
            [ { role = Role.readers, actions = [ Action.read ] }
            , { role = Role.deployers
              , actions =
                [ Action.read, Action.annotate, Action.write, Action.delete ]
              }
            , { role = Role.managers
              , actions =
                [ Action.read
                , Action.annotate
                , Action.write
                , Action.delete
                , Action.managedXrayMeta
                ]
              }
            ]
          , qa =
            [ { role = Role.readers, actions = [ Action.read ] }
            , { role = Role.deployers
              , actions =
                [ Action.read, Action.annotate, Action.write, Action.delete ]
              }
            , { role = Role.managers
              , actions =
                [ Action.read
                , Action.annotate
                , Action.write
                , Action.delete
                , Action.managedXrayMeta
                ]
              }
            ]
          , prod =
            [ { role = Role.readers, actions = [ Action.read ] }
            , { role = Role.deployers
              , actions = [ Action.read, Action.annotate, Action.write ]
              }
            , { role = Role.managers
              , actions =
                [ Action.read
                , Action.annotate
                , Action.write
                , Action.managedXrayMeta
                ]
              }
            ]
          }
          m

in  maturityRolePermissions
