---
title: Binary Search Algorithm
date: 2015-06-06 00:00:00 -0500
image:
  url: https://s3.amazonaws.com/bw.bideowego/images/binary-search-algorithm.jpg
categories: [Computer Science, Algorithm]
tags: [search, binary]
---




A <a href="https://en.wikipedia.org/wiki/Binary_search_algorithm" target="_blank">Binary Search</a> sounds incredibly intimidating. However, follows a very logical set of rules that perform an extremely efficient task.

I wanted to implement a binary search and also output exactly what decisions were being made as it runs. <a href="http://jsfiddle.net/" target="_blank">JS Fiddle</a> was perfect for this!

A binary search is used to find a value within a list of sorted values in as little iterations as possible. In order to do this my binary search performs the following operations:
<ol>
  <li>Is the search value within the min and max range of the sorted list? If so proceed.</li>
  <li>Check if the value is equal to the median of the list. If it is, the value has been found in the list and the search stops.</li>
  <li>If not, the median is excluded from the search pool and the value is checked to be greater or less than the median.</li>
  <li>If it is greater, the pool becomes only the values greater than the median. If it is lesser, the pool becomes only those values less than the median.</li>
  <li>A this time the process repeats in a pattern called recursion that begins at step 2 until a match is found.</li>
</ol>
Try out the example. Give the input a number between 1-100. Now give it a number less than 1 or greater than 100. Give it a couple numbers separated by comas!

I implemented search failure functionality as well, only in order to test it you must uncomment this line of JavaScript: `// if (i % 2 == 0) haystack.push(i);` and then comment out this line of JavaScript: `haystack.push(i);`.



<iframe class="center-block" width="75%" height="800" src="//jsfiddle.net/BideoWego/qwv52a38/embedded/result,js,html,css" allowfullscreen="allowfullscreen" frameborder="0"></iframe>








