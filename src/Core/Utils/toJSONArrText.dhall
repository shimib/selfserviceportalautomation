let concatSep = https://prelude.dhall-lang.org/Text/concatSep

let map = https://prelude.dhall-lang.org/List/map

let toJSONArrText
    : List Text → Text
    =   λ(arr : List Text)
      →     "["
        ++  concatSep "," (map Text Text (λ(elem : Text) → "\"${elem}\"") arr)
        ++  "]"

in  toJSONArrText
