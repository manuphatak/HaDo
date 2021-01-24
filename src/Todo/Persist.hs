{-# LANGUAGE DerivingStrategies #-}
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

import Data.Time (UTCTime)
import Database.Persist.Sqlite (BackendKey (..))
import Database.Persist.TH
  ( mkMigrate,
    mkPersist,
    persistLowerCase,
    share,
    sqlSettings,
  )

share
  [mkPersist sqlSettings, mkMigrate "migrateAll"]
  [persistLowerCase|
Todo
  name String
  created UTCTime default=CURRENT_TIME
  deriving Show
|]
