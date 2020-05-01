let Step = ./Step.dhall

let Entry = https://prelude.dhall-lang.org/Map/Entry

let Pipeline = { name : Text, steps : List (Entry Text Step) }

in  Pipeline
