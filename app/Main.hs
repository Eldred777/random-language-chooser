module Main where

import qualified Control.Monad (when)
import qualified System.IO as IO (hFlush, stdout)
import qualified Test.QuickCheck as QC

filterOutEmptyList :: [[x]] -> [[x]]
filterOutEmptyList [] = []
filterOutEmptyList ([] : xs) = xs
filterOutEmptyList (x : xs) = x : filterOutEmptyList xs

chooseLanguage :: [String] -> IO String
chooseLanguage [] = pure "No languages supplied."
chooseLanguage x = (QC.generate . QC.elements) x

main :: IO ()
main = do
  content <- readFile "./db/languages.db"
  let languages = (filterOutEmptyList . lines) content
  chosen <- chooseLanguage languages
  putStrLn ("Your language is: " ++ chosen)
  -- Choose another language? (loop)
  putStr "Make another choice? [y]: "
  IO.hFlush IO.stdout
  input <- getLine
  putStrLn ""
  Control.Monad.when ((== "y") input) main
