---
title: CSS3 Border Radius Transitions
image:
  url: https://s3.amazonaws.com/bw.bideowego/images/css3-border-radius-transitions.png
categories: [CSS, HTML]
tags: [transition, animation]
---




<a href="http://jsfiddle.net" target="_blank">JS Fiddle</a> is a great environment to test out your HTML, CSS and JavaScript. It is feature rich and provides a way for developers to share live code demos without needing to host it themselves.

I decided to share a few of my fiddles that I thought were particularly interesting.

The first of which is a CSS3 transition using the border-radius property. The color transition is just for effect. The real magic happens by giving the circle's  border-radius the initial value of half the width property. Then on hover set it's width to 0 pixels. This transitions the div from a circle to a square on hover.

I then decided to try something similar with only single corners of a div. This is the effect in the clover like elements below the circles.



<iframe class="center-block" width="75%" height="640" src="//jsfiddle.net/BideoWego/fszbqdqp/embedded/result,html,css" allowfullscreen="allowfullscreen" frameborder="0"></iframe>



If the above embed doesn't load you can view the full screen result <a href="https://jsfiddle.net/BideoWego/fszbqdqp/embedded/result/" target="_blank">here</a>.

Let's look at how it works! Below there is the 2 groups of 4 `div`s that make up the 8 circles. Notice the semantic CSS class names.




```html
<div class="clearfix container left">
    <div class="circle trans left"></div>
    <div class="circle trans left"></div>
    <div class="circle trans left"></div>
    <div class="circle trans left"></div>
</div>
<div class="clearfix container left">
    <div class="clover trans left"></div>
    <div class="clover trans left"></div>
    <div class="clover trans left"></div>
    <div class="clover trans left"></div>
</div>
```




Let's get the utility CSS out of the way. The below CSS floats left all the `div`s with a class of `left` and solves the common CSS float clearing problem.




```css
.clearfix:before,
.clearfix:after {
    content: '';
    display: table;
}

.cleaffix:after {
    clear: both;
}

.left {
    float: left;
}
```




Next it's time to give the `div`s some dimensions and color.




```css
.container div {
    min-width: 256px;
    min-height: 256px;
    background: #adf;
    border-radius: 128px;
}

.container {
    max-width: 512px;
}
```




Now we apply the transition to the `background` and `border-radius` property of any element with a class of `trans`. The `1s` gives the transition a duration of 1 second.




```css
.trans {
    -webkit-transition: background 1s, border-radius 1s;
    transition: background 1s, border-radius 1s;
}
```




For the clover effect we need to remove the `border-radius` from specific corners of the `div`s.




```css
.clover:nth-child(1) {
    border-bottom-right-radius: 0px;
}
.clover:nth-child(2) {
    border-bottom-left-radius: 0px;
}
.clover:nth-child(3) {
    border-top-right-radius: 0px;
}
.clover:nth-child(4) {
    border-top-left-radius: 0px;
}
```




Finally, to trigger the transition we change the `background` and `border-radius` properties on `:hover`.




```css
.circle:hover,
.clover:hover {
    background: #fda;
}

.circle:hover {
    border-radius: 0px;
}
```




Let's get a bit fancy with the clovers and transition the `0px` `border-radius` to the opposite corner.




```css
.clover:hover:nth-child(1) {
    border-bottom-right-radius: 128px;
    border-top-left-radius: 0px;
}
.clover:hover:nth-child(2) {
    border-bottom-left-radius: 128px;
    border-top-right-radius: 0px;
}
.clover:hover:nth-child(3) {
    border-top-right-radius: 128px;
    border-bottom-left-radius: 0px;
}
.clover:hover:nth-child(4) {
    border-top-left-radius: 128px;
    border-bottom-right-radius: 0px;
}
```




I hope you enjoyed this simple little example of how you can generate interesting effects by applying transitions to the `border-radius` property.





