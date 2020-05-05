let Role = ./Type.dhall

let all
    : List Role
    = [ Role.readers, Role.deployers, Role.managers ]

in  all
