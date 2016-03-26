---
title: Multi Directional Tree Traversal
date: 2016-03-25 00:00:00 -0500
image:
  url: https://s3.amazonaws.com/bw.bideowego/images/multi-directional-tree-traversal.png
categories: [Algorithm, JavaScript]
tags: [trees]
---

This will be a quick post that I will most likely update later. For now I'm pretty excited to share a little experiment I put together in JavaScript.

It is a tree rendered in HTML with node's that have attached click events. When any single node is clicked the event travels throughout the entire tree flowing up and downstream. No node is repeated in the traversal and the traversal happens up and down stream meaning `child => parent` AND `parent => child`.

I originally wrote the project using just jQuery but I decided to refactor it to use Angular.

Here is the link to the [demo](http://bideowego-multi-directional-tree-traversal.surge.sh/) and the [source on Github](https://github.com/BideoWego/multi-directional-tree-traversal/).













