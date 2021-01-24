module Todo where

import Control.Monad.Logger
import Control.Monad.Reader
import Control.Monad.Trans.Resource
import Database.Persist
import Database.Persist.Sqlite

type Action = [String] -> ReaderT SqlBackend (NoLoggingT (ResourceT IO)) ()

dispatch :: [(String, Action)]
dispatch = [("add", add), ("view", view), ("remove", remove)]

remove :: Action
remove = error "not implemented"

view :: Action
view = error "not implemented"

add :: Action
add = error "not implemented"
