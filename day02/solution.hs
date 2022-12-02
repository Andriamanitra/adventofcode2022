data BattleOutcome = Win | Lose | Draw

data RockPaperScissors = Rock | Paper | Scissors deriving (Eq)

readRPS :: String -> RockPaperScissors
readRPS "A" = Rock
readRPS "B" = Paper
readRPS "C" = Scissors
readRPS "X" = Rock
readRPS "Y" = Paper
readRPS "Z" = Scissors
readRPS _ = error "Invalid Rock-Paper-Scissors symbol"

readStrategy :: String -> BattleOutcome
readStrategy "X" = Lose
readStrategy "Y" = Draw
readStrategy "Z" = Win
readStrategy _ = error "Invalid strategy"

score :: BattleOutcome -> Int
score Lose = 0
score Draw = 3
score Win = 6

value :: RockPaperScissors -> Int
value Rock     = 1
value Paper    = 2
value Scissors = 3

whatBeats :: RockPaperScissors -> RockPaperScissors
whatBeats Rock     = Paper
whatBeats Paper    = Scissors
whatBeats Scissors = Rock

whatLosesTo :: RockPaperScissors -> RockPaperScissors
whatLosesTo = whatBeats . whatBeats

battle :: RockPaperScissors -> RockPaperScissors -> BattleOutcome
battle a b
  | a == whatBeats b = Win
  | b == whatBeats a = Lose
  | otherwise        = Draw

toTuple :: [a] -> (a, a)
toTuple [a, b] = (a, b)

main = do
    inputStr <- getContents
    let inputLines = lines inputStr

    let scoreBattle (them, i) = do
        case i `battle` them of
            Win  -> 6 + value i
            Draw -> 3 + value i
            Lose -> 0 + value i

    let readBattleStrat (theirPickStr, strat) = do
        case readStrategy strat of
            Win  -> (them, whatBeats them)
            Draw -> (them, them)
            Lose -> (them, whatLosesTo them)
            where them = readRPS theirPickStr

    let readBattlePart1 = toTuple . map readRPS . words
    let readBattlePart2 = readBattleStrat . toTuple . words
    print $ sum $ map (scoreBattle . readBattlePart1) inputLines
    print $ sum $ map (scoreBattle . readBattlePart2) inputLines
