{-# LANGUAGE OverloadedStrings, RecordWildCards #-}

module Shell.Dmenu (
      dmenu
    , DmenuOptions()
    , dmenuOptionsParser
) where

import           Prelude hiding (FilePath, lines)
import qualified Data.List as List
import qualified Data.Text as Text
import qualified Control.Foldl as Fold
import           Turtle

data DmenuOptions = DmenuOptions
    { ignoreCase      :: Bool
    }

dmenuOptionsParser :: Parser DmenuOptions
dmenuOptionsParser = DmenuOptions
    <$> switch "ignore-case" 'i' "dmenu matches items case insensitively"

dmenu :: DmenuOptions -> Shell Text -> Shell Text
dmenu options = inproc "/usr/bin/dmenu" (pass options)
  where
    pass DmenuOptions{..} =
        if ignoreCase then ["-i"] else []
