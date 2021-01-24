{-# LANGUAGE OverloadedStrings #-}

module Main where

import Control.Monad.IO.Class (MonadIO (..))
import Database.Persist.Sqlite (runMigration, runSqlite)
import System.Environment (getArgs)
import Todo.Action (dispatch)
import Todo.Persist (migrateAll)

main :: IO ()
main = runSqlite "main.sqlite3" $ do
  runMigration migrateAll

  (command : args) <- liftIO getArgs
  let (Just action) = lookup command dispatch

  action args
