{-# LANGUAGE OverloadedStrings #-}

module Main where

import Control.Monad.IO.Class
import Database.Persist.Sqlite
import Database.Persist.TH
import System.Environment
import Todo.Action
import Todo.Persist

main :: IO ()
main = runSqlite "main.sqlite3" $ do
  runMigration migrateAll

  (command : args) <- liftIO getArgs
  let (Just action) = lookup command dispatch

  action args
