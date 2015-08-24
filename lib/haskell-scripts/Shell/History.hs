module Shell.History (
      readHistory
    , withHistory
) where

import           Prelude hiding (FilePath, lines)
import qualified Control.Foldl as Fold
import           Turtle


withHistory :: FilePath -- the history file
            -> (Shell Text -> Shell Text) -- select or create an item
            -> Shell Text -- the selected or created item
withHistory file action = do
    absoluteFile <- historyFile file
    let history = _readHistory absoluteFile
    result <- action history
    append absoluteFile (return result)
    return result


readHistory :: FilePath -> Shell Text
readHistory = do
    _readHistory <=< historyFile

_readHistory :: FilePath -> Shell Text
_readHistory absoluteFile = do
    lines (input absoluteFile) >>= select . reverse
  where
    lines stream = fold stream Fold.list

historyFile :: MonadIO io => FilePath -> io FilePath
historyFile fileName = if relative fileName
    then do
        homeDir <- home
        return (homeDir </> fileName)
    else return fileName
