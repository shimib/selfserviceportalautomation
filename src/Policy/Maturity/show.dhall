let Maturity = ./Type.dhall

let show
    : Maturity → Text
    = λ(m : Maturity) → merge { dev = "dev", qa = "qa", prod = "prod" } m

in  show
