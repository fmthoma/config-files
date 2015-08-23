module Shell.History (
      readHistory
) where

import           Prelude hiding (FilePath, lines)
import qualified Control.Foldl as Fold
import           Turtle


readHistory :: FilePath -> Shell Text
readHistory file = do
    absoluteFile <- historyFile file
    -- liftIO $ print absoluteFile
    lines (input absoluteFile) >>= select . reverse
  where
    lines stream = fold stream Fold.list

historyFile :: MonadIO io => FilePath -> io FilePath
historyFile fileName = if relative fileName
    then do
        homeDir <- home
        return $ homeDir </> fileName
    else return fileName
