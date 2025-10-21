import Boardgame.RPS.Rules

namespace Boardgame
namespace RPS

/-- Single round = just the round winner. -/
def oneRound (r : Round) : Option Side :=
  winnerRound r

/-- Scoring for aggregation:
    Win = +1, Lose = −1, Tie = 0 (from the first player's perspective). -/
def scoreOf (o : Option Side) : Int :=
  match o with
  | some .First  =>  1
  | some .Second => -1
  | none         =>  0

/-- Play n rounds (given as a list) and aggregate by score sign. -/
def nRounds (rs : List Round) : Option Side :=
  let total := rs.foldl (fun acc r => acc + scoreOf (oneRound r)) 0
  if total > 0 then some .First
  else if total < 0 then some .Second
  else none

/-- Play until a non-tie is found, but with a cap to stay total.
    Returns the first decisive winner within `cap` rounds, or `none`. -/
def untilWinWithCap : Nat → List Round → Option Side
| 0,      _         => none
| _cap+1, []        => none
| cap+1,  r :: rs'  =>
  match oneRound r with
  | some s => some s
  | none   => untilWinWithCap cap rs'

end RPS
end Boardgame
