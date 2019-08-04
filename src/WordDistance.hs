module WordDistance 
    ( findMostSimilarWords
    )
where

import Data.Text (Text)
import qualified Data.Text as T

findMostSimilarWords :: Text -> [Text] -> [Text]
findMostSimilarWords word allWords = map fst $ 
    filter (\x -> snd x == bestCost) wordsAndCosts
  where
    distances = map computeDistance allWords
    computeDistance = computeLevensteinDistance word
    bestCost = minimum distances
    wordsAndCosts = zip allWords distances

computeLevensteinDistance :: Text -> Text -> Int
computeLevensteinDistance xs ys 
    | T.null xs = 0
    | T.null ys = 0
    | otherwise = minimum [ (computeLevensteinDistance (T.init xs) ys) + 1
                          , (computeLevensteinDistance xs (T.init ys)) + 1
                          , (computeLevensteinDistance (T.init xs) (T.init ys))
                           + cost
                          ]
  where
    cost = if T.last xs == T.last ys then 0 else 1



-- computeLevensteinDistance :: Text -> Text -> Int
-- computeLevensteinDistance xs ys = levMemo ! (n, m)
--   where 
--     levMemo = array ((0,0),(n,m)) [((i,j),lev i j) | i <- [0..n], j <- [0..m]]
--     n = length xs
--     m = length ys
--     xa = listArray (1, n) xs
--     ya = listArray (1, m) ys
--     lev 0 v = v
--     lev u 0 = u
--     lev u v
--         | xa ! u == ya ! v = levMemo ! (u-1, v-1)
--         | otherwise        = 1 + minimum [levMemo ! (u, v-1),
--                                           levMemo ! (u-1, v),
--                                           levMemo ! (u-1, v-1)] 