module Shell (
      module Turtle
    , module Shell.Dmenu
    , module Shell.History

    , encode
    , decode
) where

import Data.Text (pack, unpack)
import Filesystem.Path.CurrentOS (encodeString, decodeString)
import Prelude hiding (FilePath)
import Shell.Dmenu
import Shell.History
import Turtle



encode :: FilePath -> Text
encode = pack . encodeString

decode :: Text -> FilePath
decode = decodeString . unpack
