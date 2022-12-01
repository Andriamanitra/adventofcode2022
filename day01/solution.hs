import Data.List (findIndex, sort)

splitOn :: Eq a => a -> [a] -> [[a]]
splitOn sep xs =
    case findIndex (== sep) xs of
        Just i -> (take i xs) : (splitOn sep $ drop (i+1) xs)
        Nothing -> [xs]

readInput :: [[String]] -> [[Int]]
readInput = map (map read)

main = do
    input <- getContents
    let chunks = readInput $ splitOn "" $ lines input

    -- Part 1: sum of the largest chunk
    print $ maximum $ map sum chunks

    -- Part 2: sum of the largest 3 chunk sums
    print $ sum $ take 3 $ reverse $ sort $ map sum chunks
