{-# LANGUAGE OverloadedStrings #-}

import Prelude hiding (FilePath)
import Shell

main = sh $ do
    (file, arguments) <- readArguments
    outputDir <- ensureTempDir
    cacheFileName <- cacheName file
    let cacheExecutable = outputDir </> cacheFileName

    cacheHit <- testfile cacheExecutable
    unless cacheHit $ do
        let cacheSourceFile = outputDir </> cacheFileName <.> "hs"
        cp file cacheSourceFile
        compile cacheSourceFile outputDir

    run cacheExecutable arguments


readArguments :: Shell (FilePath, [Text])
readArguments = do
    (rawFile : rawArguments) <- arguments
    return (decode rawFile, rawArguments)

cacheName :: FilePath -> Shell FilePath
cacheName file = fromText <$> firstWord (md5hash file)
  where
    md5hash file = inproc "md5sum" [encode file] empty
    firstWord = inproc "awk" ["{print $1}"]

compile :: FilePath -> FilePath -> Shell ()
compile file outputDir = do
    homeDir <- home
    let includepath = homeDir </> "config-files/lib/haskell-scripts"
        ghcArgs =
            [ "-i" <> encode includepath
            , "-outputdir " <> encode outputDir
            , encode file
            ]
    (_, _) <- procStrict "ghc" ghcArgs empty
    return ()

run :: FilePath -> [Text] -> Shell ()
run executable arguments = stdout $ inproc executableName arguments stdin
  where
    executableName = encode $ executable

ensureTempDir :: Shell FilePath
ensureTempDir = do
    homeDir <- home
    tmpDir <- ensureDir (homeDir </> "tmp")
    ensureDir (tmpDir </> "haskell-scripts")
  where
    ensureDir dir = testdir dir >>= \exists -> unless exists (mkdir dir) >> return dir
