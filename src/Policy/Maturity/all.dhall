let Maturity = ./Type.dhall

let all
    : List Maturity
    = [ Maturity.dev, Maturity.qa, Maturity.prod ]

in  all
