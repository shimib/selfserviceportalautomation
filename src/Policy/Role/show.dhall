let Role = ./Type.dhall

let show =
        λ(r : Role)
      → merge
          { readers = "readers"
          , deployers = "deployers"
          , managers = "managers"
          }
          r

in  show
