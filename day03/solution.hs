import Data.List (intersect)
import Data.Char (isUpper, ord)

halve s = splitAt halfway s where halfway = div (length s) 2

value (x:_)
  | isUpper x = ord x - ord 'A' + 27
  | otherwise = ord x - ord 'a' + 1

groupsOf n [] = []
groupsOf n xs = grp : groupsOf n rest where (grp, rest) = splitAt n xs

part1 = sum . map (value . uncurry intersect . halve)
part2 = sum . map (value . foldl1 intersect) . groupsOf 3

main = do
  input <- lines <$> getContents
  print $ part1 input
  print $ part2 input
