module Todo where

type Action = [String] -> IO ()

dispatch :: [(String, Action)]
dispatch = [("add", add), ("view", view), ("remove", remove)]

remove :: Action
remove = error "not implemented"

view :: Action
view = error "not implemented"

add :: Action
add = error "not implemented"
