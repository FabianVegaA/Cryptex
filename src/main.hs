module Main where

import Data.List (elemIndex, transpose)
import Data.List.Split (splitOn) -- requiere paquete "split"5
import Data.Matrix (Matrix, fromLists)
import System.Environment (getArgs, getProgName)
import System.IO ( hClose, openFile, hGetContents, IOMode(ReadMode) )
import Data.Char (digitToInt)

tuplify2 :: [a] -> (a, a)
tuplify2 [x, y] = (x, y)

saveWords :: String -> [(String, String)]
saveWords "" = []
saveWords contents = map (tuplify2 . splitOn ",") $ lines contents

searchFor :: String -> [(String, b)] -> [String]
searchFor s dict = filter (\x -> take (length s) x == s) $ map fst dict

isComment :: String -> Bool
isComment (x : xs) = x == '#'


saveMatrix :: String -> Matrix String
saveMatrix contents = fromLists . map (splitOn " ") $ filter (not.isComment) $ lines contents

main :: IO ()
main = do
  args <- getArgs
  print args
  file_1 <- openFile (head args) ReadMode
  file_2 <- openFile (args !! 1) ReadMode
  content_1 <- hGetContents file_1
  content_2 <- hGetContents file_2
  print content_2
  let dict = saveWords content_1
  let cryptex = saveMatrix content_2
  print dict
  print cryptex
  hClose file_1
  hClose file_2
