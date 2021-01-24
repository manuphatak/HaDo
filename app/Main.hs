{-# LANGUAGE DerivingStrategies #-}
-- {-# LANGUAGE EmptyDataDecls #-}
-- {-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE UndecidableInstances #-}

module Main where

import Control.Monad.IO.Class
import Data.Time
import Database.Persist.Sqlite
import Database.Persist.TH
import System.Environment
import Todo

share
  [mkPersist sqlSettings, mkMigrate "migrateAll"]
  [persistLowerCase|
Todo
  name String
  created UTCTime default=CURRENT_TIME
  deriving Show
|]

main :: IO ()
main = runSqlite "main.sqlite3" $ do
  runMigration migrateAll

  -- currentTime <- liftIO getCurrentTime

  -- insert $ Todo "Iron the dishes" currentTime
  -- insert $ Todo "Dust the dog" currentTime

  -- allTodos <- selectList [] [Asc TodoCreated]

  -- mapM_ (liftIO . print) allTodos

  (command : args) <- liftIO getArgs

  let (Just action) = lookup command dispatch

  action args

-- action :: [String] -> ReaderT SqlBackend (NoLoggingT (ResourceT IO)) ()
-- -- action :: [String] -> transformers-0.5.6.2:Control.Monad.Trans.Reader.ReaderT SqlBackend (monad-logger-0.3.36:Control.Monad.Logger.NoLoggingT (resourcet-1.2.4.2:Control.Monad.Trans.Resource.Internal.ResourceT IO)) ()
-- action = error "not implemented"

-- liftIO $ print (allTodos @Todo)

-- janeId <- insert $ Person "Jane Doe" Nothing

-- insert $ BlogPost "My first post" johnId
-- insert $ BlogPost "My second post, for good measure" johnId

-- main = do
--   (command : args) <- getArgs
--   let (Just action) = lookup command dispatch
--   action args
