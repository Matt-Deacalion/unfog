module Query where

import           Control.Exception
import           Data.Maybe
import           Text.Read
import           Data.Time.Clock
import           Data.Duration
import           Data.Fixed
import           Data.List
import           Text.PrettyPrint.Boxes
import           Data.Aeson
import qualified Data.ByteString.Lazy.Char8    as BL

import qualified Store
import           State
import           Task
import           Utils
import           Event

data Query
  = ShowTasks [String]
  | ShowTask Number [String]
  | ShowWorktime [String]
  | Error String String
  deriving (Show)

handle :: [String] -> IO ()
handle args = do
  events <- Store.readAll
  let state = State.applyAll events
  let query = parseArgs args
  execute state events query

parseArgs :: [String] -> Query
parseArgs args = case args of
  ("list"          : args) -> ShowTasks args
  ("worktime"      : args) -> ShowWorktime args
  ("show" : number : args) -> case readMaybe number of
    Nothing     -> Query.Error "show" "task not found"
    Just number -> ShowTask number args

execute :: State -> [Event] -> Query -> IO ()
execute state events query = case query of
  ShowTasks args -> if json then printJSON else printText
   where
    json      = "--json" `elem` args
    fByTags   = filterByTags $ _context state
    fByDone   = filterByDone $ _showDone state
    tasks     = fByTags . fByDone $ _tasks state
    printJSON = BL.putStr $ encode tasks
    printText = do
      let context = [ "done" | _showDone state ] ++ _context state
      let contextStr = unwords context
            ++ if null context then "" else " [" ++ unwords context ++ "]"

      putStrLn $ "unfog: list" ++ contextStr
      prettyPrint tasks

  ShowTask number args -> showTaskIfExists
   where
    fByTags          = filterByTags $ _context state
    fByDone          = filterByDone $ _showDone state
    maybeTask        = findByNumber number $ fByTags . fByDone $ _tasks state
    showTask         = prettyPrint . flip (:) [] <$> maybeTask
    showError        = elog "show" "task not found"
    showTaskIfExists = fromMaybe showError showTask

  ShowWorktime args -> do
    now <- getCurrentTime
    let tags      = filter startsByPlus args
    let ids       = map _id $ filterByTags args $ _tasks state
    let worktimes = foldl (getWorktime now ids) [] events
    let durations = map (mapToDuration now) worktimes
    let total     = sum $ map snd durations
    putStrLn $ "unfog: worktime " ++ if null args
      then "global"
      else "[" ++ unwords tags ++ "]"
    putStrLn $ approximativeDuration total

  Query.Error command message -> elog command message

mapToDuration :: UTCTime -> Worktime -> (Id, Micro)
mapToDuration now (id, (starts, stops)) = (id, diff)
 where
  lastStop = [ now | length starts > length stops ]
  diff     = realToFrac $ sum $ zipWith diffUTCTime (stops ++ lastStop) starts

type Worktime = (Id, ([UTCTime], [UTCTime]))
getWorktime :: UTCTime -> [Id] -> [Worktime] -> Event -> [Worktime]
getWorktime now ids acc event = case event of
  TaskStarted start id _ -> ifMatchId id $ case lookupAcc id of
    Nothing -> (id, ([start], [])) : acc
    Just (_, (starts, stops)) ->
      (id, (starts ++ [start], stops)) : accWithout id

  TaskStopped stop id _ -> ifMatchId id $ case lookupAcc id of
    Nothing -> (id, ([], [stop])) : acc
    Just (_, (starts, stops)) ->
      (id, (starts, stops ++ [stop])) : accWithout id

  TaskDeleted _ id _ -> accWithout id

  _                  -> acc
 where
  ifMatchId id next = if id `elem` ids then next else acc
  lookupAcc id = find ((==) id . fst) acc
  accWithout id = filter ((/=) id . fst) acc