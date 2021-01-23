module Main where

import System.Environment
import Todo

main :: IO ()
main = do
  (command : args) <- getArgs
  let (Just action) = lookup command dispatch
  action args
