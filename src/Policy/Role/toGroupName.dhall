let Role = ./Type.dhall

let show = ./show.dhall

let toGroupName
    : Role → Text → Text
    = λ(r : Role) → λ(team : Text) → "${team}-${show r}"

in  toGroupName
