namespace Boardgame
namespace RPS

/-- Rock–Paper–Scissors hands. -/
inductive Hand
| Rock | Paper | Scissors
deriving DecidableEq, Repr

/-- Which side (to combine with `Option`). -/
inductive Side
| First | Second
deriving DecidableEq, Repr

/-- One round input (what each side plays). -/
structure Round where
  fst : Hand
  snd : Hand
deriving Repr

/-- Result of comparing two hands from the first player's perspective. -/
inductive Result
| Win | Lose | Tie
deriving DecidableEq, Repr

/-- Emoji aliases (convenient names to write hands). -/
def «✊» : Hand := .Rock
def «✋» : Hand := .Paper
def «✌️» : Hand := .Scissors

/-- Convert a hand to its emoji for pretty printing. -/
def emoji : Hand → String
| .Rock     => "✊"
| .Paper    => "✋"
| .Scissors => "✌️"

instance : ToString Hand where
  toString := emoji

instance : ToString Side where
  toString
  | .First  => "First"
  | .Second => "Second"

/-- Optional winner pretty-printing (so `s!"{x}"` prints nicely). -/
instance : ToString (Option Side) where
  toString
  | some .First  => "some First"
  | some .Second => "some Second"
  | none         => "none"

/-- Core rule: from the first hand's perspective.
    Order: Tie → Win → (otherwise) Lose. -/
def beats (a b : Hand) : Result :=
  if a = b then
    .Tie
  else match a, b with
    | .Rock,     .Scissors => .Win
    | .Paper,    .Rock     => .Win
    | .Scissors, .Paper    => .Win
    | _, _                 => .Lose

/-- Winner as `Option Side`: some First / some Second / none (tie). -/
def winner (a b : Hand) : Option Side :=
  match beats a b with
  | .Win  => some .First
  | .Lose => some .Second
  | .Tie  => none

/-- Winner for a `Round`. -/
def winnerRound (r : Round) : Option Side :=
  winner r.fst r.snd

/-- Basic safety lemmas you might want later. -/
theorem winner_self (a : Hand) : winner a a = none := by
  simp [winner, beats]

theorem winner_symm_first (a b : Hand) :
    winner a b = some .First ↔ winner b a = some .Second := by
  cases a <;> cases b <;> decide

theorem winner_exhaustive (a b : Hand) :
    winner a b = some .First ∨ winner a b = some .Second ∨ winner a b = none := by
  cases a <;> cases b <;> decide

end RPS
end Boardgame
