import Boardgame.RPS.Games

open Boardgame.RPS

def main : IO Unit := do
  let r1 : Round := { fst := «✊», snd := «✌️» }   -- First wins
  let r2 : Round := { fst := «✋», snd := «✌️» }   -- Second wins
  let r3 : Round := { fst := «✊», snd := «✊» }   -- Tie

  IO.println s!"oneRound r1 = {oneRound r1}"
  IO.println s!"oneRound r2 = {oneRound r2}"
  IO.println s!"oneRound r3 = {oneRound r3}"

  let series := [r1, r2, r3, r1]  -- score: +1 -1 0 +1 => +1 => First
  IO.println s!"nRounds series = {nRounds series}"

  IO.println s!"untilWinWithCap 3 [r3, r3, r2] = {untilWinWithCap 3 [r3, r3, r2]}"
  IO.println s!"untilWinWithCap 2 [r3, r3, r2] = {untilWinWithCap 2 [r3, r3, r2]}"
