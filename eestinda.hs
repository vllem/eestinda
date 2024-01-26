import System.IO
import System.Environment
import System.FilePath
import System.Exit (exitFailure)

replaceChars :: String -> Bool -> String
replaceChars content reverseFlag = map replaceChar content
  where
    replaceChar c
      | not reverseFlag = case c of
          'ö' -> '8'
          'ä' -> '2'
          'ü' -> 'y'
          'õ' -> '6'
          _   -> c
      | otherwise = case c of
          '8' -> 'ö'
          '2' -> 'ä'
          'y' -> 'ü'
          '6' -> 'õ'
          _   -> c

main :: IO ()
main = do
    args <- getArgs
    case parseArgs args of
      Just (reverseFlag, filename) -> processFile reverseFlag filename
      Nothing -> printUsage

processFile :: Bool -> FilePath -> IO ()
processFile reverseFlag filename = do
    content <- readFile filename
    let modifiedContent = replaceChars content reverseFlag
    let (baseName, ext) = splitBaseNameAndExtension filename
    let newFilename = baseName ++ (if reverseFlag then "_tagurpidi-eestinda" else "_eestinda") ++ ext
    writeFile newFilename modifiedContent
    putStrLn $ "File processed and saved as " ++ newFilename

parseArgs :: [String] -> Maybe (Bool, FilePath)
parseArgs args = case args of
    ["--reverse", "--input", filename] -> Just (True, filename)
    ["--reverse", "-i", filename] -> Just (True, filename)
    ["-r", "--input", filename] -> Just (True, filename)
    ["-r", "-i", filename] -> Just (True, filename)
    ["--input", filename] -> Just (False, filename)
    ["-i", filename] -> Just (False, filename)
    _ -> Nothing

printUsage :: IO ()
printUsage = do
    putStrLn "Usage: eestinda [--reverse] --input <filename>"
    putStrLn "       eestinda [-r] -i <filename>"
    exitFailure

splitBaseNameAndExtension :: FilePath -> (String, String)
splitBaseNameAndExtension path = (dropExtension base, ext)
  where
    (dir, base) = splitFileName path
    ext = takeExtension base

