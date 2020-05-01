let Action = ./Action.dhall

let actionShow
    : Action → Text
    =   λ(a : Action)
      → merge
          { read = "read"
          , write = "write"
          , annotate = "annotate"
          , manage = "manage"
          , delete = "delete"
          , distribute = "distribute"
          , managedXrayMeta = "managedXrayMeta"
          }
          a

in  actionShow
