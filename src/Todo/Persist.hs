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

module Todo.Persist where

import Control.Monad.IO.Class
import Data.Time
import Database.Persist.Sqlite
import Database.Persist.TH

share
  [mkPersist sqlSettings, mkMigrate "migrateAll"]
  [persistLowerCase|
Todo
  name String
  created UTCTime default=CURRENT_TIME
  deriving Show
|]
