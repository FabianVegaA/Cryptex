module Main where

import Data.Char (digitToInt)
import Data.List (elemIndex, length, transpose)
import Data.List.Split (splitOn)
import System.Environment (getArgs, getProgName)
import System.IO (IOMode (ReadMode), hClose, hGetContents, openFile)

type Dict = [(String, String)]

type MatrixS = [[String]]

-- This transform a list the lenght 2 to a tuple
tuplify2 :: [a] -> (a, a)
tuplify2 [x, y] = (x, y)

-- Save the words the a file CSV like a dictionary
saveWords :: String -> Dict
saveWords "" = []
saveWords contents = map (tuplify2 . splitOn ",") $ lines contents

-- Verify if a value is a comment, mainly if containt a '#' in a line
isComment :: String -> Bool
isComment (x : xs) = x == '#'

-- Get a matrix of a string
saveMatrix :: String -> MatrixS
saveMatrix contents = map (splitOn " ") $ filter (not . isComment) $ lines contents

-- Get a value of a dictionary
getValueDict :: String -> Dict -> Maybe String
getValueDict s [] = Nothing
getValueDict s ((key, value) : ts) =
  if s == key
    then Just value
    else getValueDict s ts

-- Verify if a element is into the a list of the same type
isInList :: Eq a => a -> [a] -> Bool
isInList x xs = (> 0) $ sum $ map (\i -> if i == x then 1 else 0) xs

-- Search in the columns the characters of a word
isInC :: String -> MatrixS -> Bool
isInC w m = all (\i -> isInList [w !! i] $ m !! i) [0 .. length w - 1]

-- Filter the words that contenin a matrix of the dictionary
findWord :: Dict -> MatrixS -> Dict
findWord d m =
  filter (\(key, value) -> isInC key $ transpose m) $
    filter (\(i, j) -> length i == length (head m)) d

-- Calculate the minimum distance the a character in a list
calculateD :: String -> [String] -> Int
calculateD c l = minimum $ head $ map (\(i, j) -> [j, abs $ length l - j]) index_l
  where
    -- This creates pairs the values and its position relative to the column (a list)
    -- After apply a filter to get the a list with of the character and its position
    index_l = filter (\(i, j) -> i == c) $ map (\i -> (l !! i, i)) [0 .. length l - 1]

-- Iterate each word in the matrix to calculate the distance
distanceRotate :: Dict -> MatrixS -> [(String, Int)]
distanceRotate d m = map (\(key, value) -> (key, moviments key)) d
  where
    moviments = \key -> sum $ map (\i -> calculateD [key !! i] $ transpose m !! i) [0 .. length key - 1]

main :: IO ()
main = do
  args <- getArgs
  file_1 <- openFile (head args) ReadMode
  file_2 <- openFile (args !! 1) ReadMode
  content_1 <- hGetContents file_1
  content_2 <- hGetContents file_2
  let dict = saveWords content_1
  let cryptex = saveMatrix content_2
  let words = findWord dict cryptex
  let distances = distanceRotate words cryptex
  putStrLn $ concatMap (\(i, j) -> i ++ " (" ++ show j ++ " moves)\n") distances
  hClose file_1
  hClose file_2
