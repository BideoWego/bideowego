---
title: Othello Game with AngularJS
date: 2016-04-08 00:00:00 -0500
image:
  url: https://s3.amazonaws.com/bw.bideowego/images/othello-game-with-angularjs.jpg
categories: [Game, JavaScript]
tags: [angularjs]
---

Some may know the game as [Othello](https://en.wikipedia.org/wiki/Othello_(video_game)) for Nintendo and some may know the game as [Reversi](https://en.wikipedia.org/wiki/Reversi), but both refer to the same brain teasing game of wits.

I used to play this game in the arcade and the original NES. I always was curious about implementing it myself. Recently I did so using [AngularJS](https://angularjs.org).

Implementing a game with any kind of MVC framework always has it's challenges. For the most part it was fairly straight forward to separate game logic into [Angular services](https://docs.angularjs.org/guide/services). Try [playing](http://bideowego-othello.surge.sh/) against the computer in "1 Player" mode! Don't under estimate it, while it chooses moves at random it still can surprise you!




## Othello Rules

The idea of the game is:

1. A player places a disk that surrounds at least 1 disk of the opposing player
1. This results in all disks of the opposing player being flipped to the original player's color
1. If the next player has moves to make, the player moves
1. If not the turn skips that player
1. The game continues until the board is full or no player has a move
1. The player with the most disks wins




## Algorithmic Challenges

Particularly interesting challenges programming the logic of the game include:

1. Checking to see if a player has moves
1. When a move is made, all disks between that player's disks must be gathered and flipped

### Getting Flippable Disks

Gathering all the flippable disks for a player involves thinking in multiple directions on a 2D grid. From any given point, you must travel in all 4 [cardinal directions](https://en.wikipedia.org/wiki/Cardinal_direction) and diagonals. You must also remain in the bounds of the grid while doing so. This is a nested loop operation.

The pseudocode for this would be something like this:

```
1. For each direction
1. Move square by square in that direction
1. If the x or y is out of bounds move to the next direction
1. If the disk color is not the same as the current player add it to the list
1. If the disk color is the same as the current player push each disk on the current list onto a total collection of disks to flip
```

The most important concept of the above is that we only really flip the total collection after all flippable disks have been found. Disks may be added to the temporary list during the search, however they are discarded if we do not find a disk that matches the current player's color.

### Can a Player Move?

The nice thing about these two problems is one is actually dependent on the other. In order to flip all the disks of a move you need to get the potential "flippable" disks given a certain `x,y` coordinate the player may place their disk. Implementing this functionality gives you the ability to check if a player has moves in the first place.

Traversing the board, if no square (set of `x,y` coordinates) returns a list of potential flippable disks then the player has no moves!




## The Computer

After implementing the above, the computer is not too difficult to create either. Since we're already getting a list of potential moves to check if a given player should be allowed a turn or not, we can return that list of moves to an artificial player (the computer) and select a move at random.



## Play It!

Enough talk, play the [demo](http://bideowego-othello.surge.sh/) and view the [code](https://github.com/BideoWego/othello).






