let Role = ./TYpe.dhall

let all
    : List Role
    = [ Role.readers, Role.deployers, Role.managers ]

in  all
