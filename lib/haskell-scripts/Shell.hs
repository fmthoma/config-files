module Shell (
      module Turtle
    , module Shell.Dmenu
    , module Shell.History

    , encode , decode
    , foldIO , fold
    , uniq
) where

import qualified Control.Foldl as Fold
import Data.Text (pack, unpack)
import Filesystem.Path.CurrentOS (encodeString, decodeString)
import Prelude hiding (FilePath, nub)
import Shell.Dmenu
import Shell.History
import Turtle hiding (foldIO, fold)
import qualified Turtle as StupidTurtle



encode :: FilePath -> Text
encode = pack . encodeString

decode :: Text -> FilePath
decode = decodeString . unpack


foldIO :: MonadIO io => FoldM IO a r -> Shell a -> io r
foldIO = flip StupidTurtle.foldIO

fold :: MonadIO io => Fold a b -> Shell a -> io b
fold = flip StupidTurtle.fold


uniq :: Ord a => Shell a -> Shell a
uniq = fold Fold.nub >=> select
