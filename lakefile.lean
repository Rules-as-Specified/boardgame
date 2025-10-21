import Lake
open Lake DSL

package boardgame

require mathlib from git
  "https://github.com/leanprover-community/mathlib4" @ "master"

lean_lib Boardgame

lean_exe Main where
  root := `Main
