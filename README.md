# Haskell Sandpiles
This is a basic implementation of the Abelian sandpile model using Haskell and Gloss.

![20k Grains of Sand](/screenshots/20k.png?raw=true "Optional Title")

Currently starts a single sandpile of 20k in the very middle. If you'd like to change this, you can alter the source and change the Map in the main. 

    Map.fromList [((0, 0), 20000)]

The list is of format

    [((x, y), n)]

Where x, y, and n are integers that represent the sandpile's position on the grid and the number of grains.

### Controls
Use the arrow keys or drag with the left mouse to move.

PageUp and PageDown or drag with the right mouse to zoom in and out. According to Gloss' documentation, the mouse wheel should work too, but it hasn't been working for me.

### TODO:
- Pause/Play
- Stepping through simulation
- Add sandpiles by clicking

### License
View the LICENSE file. Standard BSD-3-Clause.