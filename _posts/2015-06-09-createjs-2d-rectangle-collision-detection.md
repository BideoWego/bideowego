---
title: CreateJS 2D Rectangle Collision Detection
date: 2015-06-09 00:00:00 -0500
image:
  url: https://s3.amazonaws.com/bw.bideowego/images/createjs-2d-rectangle-collision-detection.png
categories: [JavaScript, Game]
tags: [collision-detection]
---


Ever wonder how 2D games know if your player is hit by that enemy over there?

Here is an illustrative example I made on JS Fiddle. It takes 2 rectangles and highlights their collision in red. The rectangles are movable so mess around with it! The example uses <a href="http://www.createjs.com" target="_blank">CreateJS</a> to draw and update.

What is nice about JS Fiddle is it allows you to see the code, and change it if you want!

Under the hood, the code checks to see if the area created by what "should" be the 4 points of the intersecting rectangle is greater than 0. If so, the red rectangle is drawn, if not, no collision, no red rectangle for you!

The full code and example are <a href="https://jsfiddle.net/BideoWego/mLwrasng/" target="_blank">here</a> on JS Fiddle.

<iframe width="100%" height="800" src="//jsfiddle.net/BideoWego/mLwrasng/embedded/result,js,html" allowfullscreen="allowfullscreen" frameborder="0"></iframe>



## Relevant Code


```javascript
function intersect(r1, r2) {

  // determine which rectangle
  // is left, right, top, bottom
  var leftMost = (r1.x < r2.x) ? r1 : r2;
  var rightMost = (r1.x > r2.x) ? r1 : r2;
  var upMost = (r1.y < r2.y) ? r1 : r2;
  var downMost = (r1.y > r2.y) ? r1 : r2;
  
  // get the 4 corners of what
  // would be the intersection rectangle
  var upperLeft = [rightMost.x, downMost.y];
  var upperRight = [leftMost.x + leftMost._bounds.width, downMost.y];
  var lowerLeft = [rightMost.x, upMost.y + upMost._bounds.height];
  var lowerRight = [leftMost.x + leftMost._bounds.width, upMost.y + upMost._bounds.height];
  
  // get the origin point
  var x = upperLeft[0];
  var y = upperLeft[1];
  
  // get width and height
  var width = upperRight[0] - upperLeft[0];
  var height = lowerLeft[1] - upperLeft[1];
  
  // there is no intersection if
  // width or height is negative
  if (width < 0 || height < 0) {
      width = 0;
      height = 0;
  }
  
  // here we draw the intersecting rectangle
  var r = drawRect(x, y, width, height, '#f00', '#f00');
  
  return r;
}
```



