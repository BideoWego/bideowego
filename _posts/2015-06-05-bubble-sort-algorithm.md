---
title: Bubble Sort Algorithm
date: 2015-06-05 00:00:00 -0500
image:
  url: https://s3.amazonaws.com/bw.bideowego/images/bubble-sort-algorithm.jpg
categories: [Algorithm, JavaScript]
tags: [sorting]
---


I decided with my lack of computer science knowledge it was time to test out implementing a few algorithms commonly used in the computer science world.

One of these is the <a href="https://en.wikipedia.org/wiki/Bubble_sort" target="_blank">Bubble Sort</a> sorting algorithm. The logic behind it is this:
<ol>
  <li>Each pair of values is compared (a, b)</li>
  <li>If the value to the left is greater than the value to the right (a &gt; b), then the value to the left (a) is switched with the value to the right (b)</li>
  <li>This process is repeated until 1 full sweep of all of the values completes without any switches make, thus resulting in a fully sorted list of values from least to greatest</li>
</ol>
I know my implementation is not superb, but it works and further it outputs exactly what is happening at each step of the logic.

Try it out, copy and past one of the examples into the input and click Sort. Enjoy!

<iframe class="center-block" width="75%" height="800" src="//jsfiddle.net/BideoWego/oafhqLaa/embedded/result,js,html,css" allowfullscreen="allowfullscreen" frameborder="0"></iframe>


## Condensed Code

If you have a look at the JavaScript for the JS Fiddle above you're going to get a bit lost in logging function calls. The condensed code for a bubble sort is much more compact.

I added a few comments to point out important parts.



```javascript
var bubbleSort =  function(array) {

  // initialize variables
  var n = array.length;
  var didSwap = true;

  while (didSwap) {

    // assument no swap was made
    didSwap = false;

    for (var i = 0; i <= n; i++) {

      // get current and next values
      var a = array[i];
      var b = array[i + 1];

      // important to check here if we have values
      // for both a and b
      if (
          (a !== 'undefined' && b !== 'undefined') &&
          (a > b)
        ) {

        // if a (previous value)
        // is greater than b (next value)
        // swap'em and set a flag to
        // loop again
        array[i] = b;
        array[i + 1] = a;
        didSwap = true;
      }
    }
    // a bubble sort optimization
    // each iteration the n - 1 item
    // will be sorted
    // so we exclude that index
    // by decrementing n
    n--;
  }
  return array;
};
```


