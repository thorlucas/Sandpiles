module Main where

import qualified Data.Map as Map
import Graphics.Gloss
import Graphics.Gloss.Interface.IO.Simulate

type Position = (Int, Int)
type Sandpile = (Position, Int)
type SpMap = (Map.Map (Int, Int) Int)

tileSize :: Float
tileSize = 1

data Game = Game SpMap

spColor :: Int -> Color
spColor n
    | n == 1 = red
    | n == 2 = orange
    | n == 3 = yellow
    | n == 4 = green
    | n == 5 = blue
    | n == 6 = magenta
    | n >= 7 = violet

spTopple :: Position -> Int -> [Sandpile]
spTopple (x, y) n
    | n <= 3 = [((x, y), n)]
    | otherwise = [((x, y), (n `mod` 4)), ((x, y+1), e), ((x, y-1), e), ((x+1, y), e), ((x-1, y), e)]
    where
        e = floor $ fromIntegral n / 4

render :: Game -> IO Picture
render (Game msps) = return $ pictures $ map renderSandpile sps
    where
        sps = Map.toList msps
        renderSandpile ((x, y), n) = translate (fromIntegral x*tileSize) (fromIntegral y*tileSize) $
                                     color (spColor n) $
                                     rectangleSolid tileSize tileSize

update :: ViewPort -> Float -> Game -> IO Game
update _ _ game@(Game msps) = return (Game msps')
    where
        msps' = Map.filter (>0) $ Map.foldWithKey topple Map.empty msps
        topple :: Position -> Int -> SpMap -> SpMap
        topple p n acc = foldl addSpToMap acc (spTopple p n)
        addSpToMap :: SpMap -> Sandpile -> SpMap
        addSpToMap acc (p, n) = Map.insertWith (+) p n acc

window :: Display
window = InWindow "Sandpiles" (640, 480) (100, 100) 

main :: IO ()
main = simulateIO window black 60 (Game (Map.fromList [((0, 0), 10)])) render update