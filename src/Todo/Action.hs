{-# LANGUAGE TypeApplications #-}

module Todo.Action where

import Control.Monad.Logger
import Control.Monad.Reader
import Control.Monad.Trans.Resource
import Data.Time
import Database.Persist
import Database.Persist.Sqlite
import Todo.Persist

type Action = [String] -> ReaderT SqlBackend (NoLoggingT (ResourceT IO)) ()

dispatch :: [(String, Action)]
dispatch = [("add", add), ("view", view), ("remove", remove), ("seed", seed)]

seed :: Action
seed _ = do
  currentTime <- liftIO getCurrentTime

  insert $ Todo "Iron the dishes" currentTime
  insert $ Todo "Dust the dog" currentTime
  insert $ Todo "Take salad out of the oven" currentTime

  allTodos <- selectList [] [Asc TodoCreated]
  mapM_ (liftIO . print) allTodos

remove :: Action
remove [numberString] = do
  let i = read @Int numberString

  Just todo <- selectFirst [] [Asc TodoCreated, OffsetBy (i - 1)]
  delete . entityKey $ todo

view :: Action
view _ = do
  allTodos <- selectList [] [Asc TodoCreated]
  mapM_ (liftIO . putStrLn) . zipWith asList [1 ..] . map (todoName . entityVal) $ allTodos
  where
    asList :: Integer -> String -> String
    asList i todo = show i ++ " - " ++ todo

add :: Action
add [newTodo] = do
  currentTime <- liftIO getCurrentTime

  insert $ Todo newTodo currentTime

  return ()
