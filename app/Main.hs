module Main where

import System.IO hiding (withFile)

main :: IO ()
main = do
  withFile "girlfriend.txt" ReadMode go
  where
    go :: Handle -> IO ()
    go handle = do
      contents <- hGetContents handle

      putStr contents

-- handle <- openFile
-- contents <- hGetContents handle
-- putStr contents
-- hClose handle

withFile :: FilePath -> IOMode -> (Handle -> IO r) -> IO r
withFile file mode fn = do
  handle <- openFile file mode
  result <- fn handle
  hClose handle

  return result
