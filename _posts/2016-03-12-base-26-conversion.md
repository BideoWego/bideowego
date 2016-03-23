---
title: Base 26 Conversion
date: 2016-03-12 00:00:00 -0500
image:
  url: https://s3.amazonaws.com/bw.bideowego/images/base-26-conversion.jpg
categories: [Algorithm, Math]
tags: [javascript, ruby, base-26]
---

I was working on a project that used [Google spreadsheets](https://www.google.com/sheets/about/) to store data. The catch was that the API wrapper referred to the columns in the spreadsheet by number. However, columns in spreadsheets are named with letters. Once `Z` is reached the next column is prefixed with an `A` so it appears as `AA`. This is [base 26](http://www.minus40.info/sky/alphabetcountdec.html).


In order to make the conversion of number to column completely dynamic I had to convert the number to its base 26 letter value. It is also helpful to be able to reverse the operation whenever desired. This means taking the string `AA` for instance and converting it into `27`.

Originally I wrote this code in Ruby, however I wanted to port it to JavaScript.









## Generating a Char Range


If you've ever worked with [Ruby ranges](http://ruby-doc.org/core-2.3.0/Range.html) you know how easy it is to generate a character range in Ruby. It is also just as simple to convert that range into an array.

```ruby
# Ruby

alpha = ('a'..'z').to_a
```

Not so much in JavaScript. There is no native way to generate a char range in JavaScript. So the first step was to generate an array of all the characters from `a` to `z`.

While JavaScript doesn't have native ranges, it does have some easy to work with unicode functions. Specifically the [`string.charCodeAt` method](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/charCodeAt).

This bit of code works because the unicode integer representations of characters are in alphabetical and numerical order.

```javascript
// JavaScript

function charRange(start, stop) {
  var result = [];

  // get all chars from starting char
  // to ending char
  var i = start.charCodeAt(0),
      last = stop.charCodeAt(0) + 1;
  for (i; i < last; i++) {
    result.push(String.fromCharCode(i));
  }

  return result;
}
```

Now we have a function that can produce an array like this:


```javascript
['a', 'b', 'c', 'd', ... 'z']
```

This gives us all the tools we need to do base 26 conversions.









## Base 10 Integer to Base 26 String


Now comes the fun part (I bet you were waiting for the fun part). Let's take that char array and use it to convert an integer like `334123303` into `abcdefg`. Why? Because you never know when you might need to do that.


First we need the array of alphabetic chars to work with.

```javascript
var alpha = charRange('a', 'z');
```

We'll also need a variable to which we'll concatenate our various letters.

```javascript
var result = '';
```

Now it's time to convert a given string to an integer. For our purposes we'll assume the string is all lowercase alphabetical characters.

Let's think about this strategically. We need to think in base 26. To quickly illustrate what that means, let's think in binary (base 2). The number `2` is represented by `10`. This is because what we consider to be the tens position now has a value of `2` for each increment. If it were base 26 then each increment of the tens position would have a value of `26`. However, there aren't 26 different numbers to represent all of those values in the ones place.

The solution to this problem is to use letters in place of numbers. There are 26 letters so it works perfectly. This means `3` will now be `c` (this is assuming `a` is `1`).

If we were finding the value of each position in base 10 we'd need to divide by `10` until we get `0`, each time taking the remainder as the value of that position.

Example:

```javascript
var n = 1234;
var quotient = Math.floor(n / 10);
//=> 123

var remainder = n % 10;
//=> 4
```

We repeat this process and eventually we'll get the value of each position, `4`, `3`, `2`, `1`. However we want letters not numbers and we're using base 26 not base 10. Luckily the approach doesn't change much. Here is the function that will convert an integer to a base 26 string:


```javascript
function toString26(num) {
  var alpha = charRange('a', 'z');
  var result = '';

  // no letters for 0 or less
  if (num < 1) {
    return result;
  }

  var quotient = num,
      remainder;

  // until we have a 0 quotient
  while (quotient !== 0) {
    // compensate for 0 based array
    var decremented = quotient - 1;

    // divide by 26
    quotient = Math.floor(decremented / 26);

    // get remainder
    remainder = decremented % 26;

    // prepend the letter at index of remainder
    result = alpha[remainder] + result;
  }

  return result;
}
```

The key take away here is the use of the quotient and remainder. The quotient represents what place we're in. The remainder represents the value of that place.

When we reach a quotient of `0` we know we're done. No more places to divide by `26`.

We compensate for the array being zero indexed by subtracting `1` from the quotient each iteration. So `26` will become `25` and return a value of `z` at index `25` of the array.

As you saw above, we get the ones place first, tens place next, and etc. So we prepend the value to our result string to get the correct order.

That's it! This approach is also fast.Indexing into an array is very fast, `O(1)`.In `toString26` we're dividing in our iteration so we're chunking large numbersdown by a big amount.Each time we iterate the new number we're dividing is the `quotient`from the last iteration.The time complexity comes out to be `O(log n)`.It's worth noting that the base of the `log` is `26` and makes thisfaster than a base of `2`. But it is a constant and therefore left out.









## Base 26 String to Base 10 Integer

Next let's convert that integer back into a base 26 string. We'll need a similar group of variables to work with at the beginning. An alphabet array and a result integer to accumulate the sum.

```javascript
var alpha = charRange('a', 'z');
var result = 0;
```

Next we'll need to iterate over each of the characters of the string. Each character represents a position in a base 26 number. This means the last position represents `n` multiplied by `26` to the power of it's string index `0`. This will boil down to `n * 1` because any number to the power `0` is `1`. Next we'll get this equation `n * 26`, and then `n * (26^2)`, and etc.

We'll compensate for the zero indexed array in this case by incrementing position. But we must do it **AFTER** we retrieve the letter from the `alpha` array.

The trick to this bit of code is to iterate backwards over the string with `i`, but still have a forward iterator `j` to set the power of `26` by which we multiply the position.


Here is the code:


```javascript
function toInt26(str) {
  var alpha = charRange('a', 'z');
  var result = 0;

  // make sure we have a usable string
  str = str.toLowerCase();
  str = str.replace(/[^a-z]/g, '');

  // we're incrementing j and decrementing i
  var j = 0;
  for (var i = str.length - 1; i > -1; i--) {
    // get letters in reverse
    var char = str[i];

    // get index in alpha and compensate for
    // 0 based array
    var position = alpha.indexOf(char);
    position++;

    // the power kinda like the 10's or 100's
    // etc... position of the letter
    // when j is 0 it's 1s
    // when j is 1 it's 10s
    // etc...
    var power = Math.pow(26, j);

    // add the power and index to result
    result += power * position;
    j++;
  }

  return result;
}
```
The time complexity of `toInt26` is `O(n)` where `n` is the length of the string passed to the function. Keep in mind that while `O(n)` is not a fast time complexity in this context it is completely acceptable and the function itself is very fast. A string of the entire alphabet produces an integer value of `256094574536617744129141650397448476`. The function above would only need `26` iterations to produce that number. While time complexities of `O(n)` can seem slow on the surface it is important to realize how they are applied to truly weigh their effectiveness.

Also `O(n)` may be the time complexity in reference to the length of the string. However the underlying time complexity for `toInt26` is really `O(log n)`. This is because we are really iterating over a string representation of a number. Effectively, by analyzing each character in reverse we are performing a similar operation to `toString26` which has a time complexity of `O(log n)`. It depends on how you view the problem.


## Test cases

Here are a few test cases to try out our new base 26 conversion functions:


```javascript
var str,
    num;

num = toInt26('a');
str = toString26(num);
console.log(str, num);
//=> a 1

num = toInt26('z');
str = toString26(num);
console.log(str, num);
//=> z 26

num = toInt26('aa');
str = toString26(num);
console.log(str, num);
//=> aa 27

num = toInt26('abc');
str = toString26(num);
console.log(str, num);
//=> abc 731

num = toInt26('abcdefg');
str = toString26(num);
console.log(str, num);
//=> abcdefg 334123303

num = toInt26('abcdefghijklm');
str = toString26(num);
console.log(str, num);
//=> abcdefghijklm 103215959525275440
```

**NOTE**: It has recently come to my attention that the JavaScript versions of these functions seem to stop working correctly around `'abcdefghijklmn'`. This has to do with JavaScript not supporting very large integers. Under the hood, integers that are larger than the max integer value are converted to scientific notation which breaks the function.

A solution to this problem may appear later, but is a good talking point for the moment.

**BROKEN CODE:**

```javascript
num = toInt26('abcdefghijklmn');
console.log(num);
//=> 2683614947657161700

str = toString26(num);
num = toInt26(str);
console.log(str, num);
//=> abcdefghijkmcc 2683614947657161700 // <<<< WRONG!!!!
```

Here's the kicker, the Ruby version of this code does **NOT** suffer from this side effect. This is providing that the `to_s26` method is defined on `Bignum` and `Fixnum`.

Here is the Ruby code:


```ruby
module Base26
  ALPHA = ('a'..'z').to_a

  module Number
    def to_s26
      # initialize an empty string
      str = ''

      # return that string if
      # value is not at least 1
      # which would be 'a'
      return str if self < 1

      # initialize quotient to this value
      quotient = self

      # until we get to 0
      until quotient.zero?
        # get the result and remainder
        # of (q - 1) / 26
        quotient, remainder = (quotient - 1).divmod(26)

        # prepent that str with
        # the value at the index of
        # the remainder
        str.prepend(ALPHA[remainder]) 
      end
      str
    end
  end
end


class Fixnum
  include Base26
  include Base26::Number
end


class Bignum
  include Base26
  include Base26::Number
end


class String
  include Base26

  def to_i26
    # initialize the return value to 0
    result = 0

    # ensure we only have lowercase alpha chars
    downcase!
    gsub!(/[^a-z]/, '')

    # iterate backwards over string
    (1..length).each do |index|
      # get char at index
      char = self[-index]

      # get numeric position in alpha
      position = ALPHA.index(char)

      # get the value of 26
      # to the power of the current index
      power = 26**(index - 1)

      # compensate for array being 0 indexed
      position += 1

      # add to result
      result += power * position
    end
    result
  end
end


if __FILE__ == $0
  p({
    :original => 'foobar',
    :to_i26 => 'foobar'.to_i26,
    :to_s26 => 'foobar'.to_i26.to_s26
  })

  p({
    :original => 1234567890,
    :to_s26 => 1234567890.to_s26,
    :to_i26 => 1234567890.to_s26.to_i26
  })

  p({
    :original => 'abcdefghijklmnopqrstuvwxyz',
    :to_i26 => 'abcdefghijklmnopqrstuvwxyz'.to_i26,
    :to_s26 => 'abcdefghijklmnopqrstuvwxyz'.to_i26.to_s26
  })
end
```

Yet another reason why Ruby is just awesome.



## Conclusion

Math problems like this are interesting to implement in various languages. Each language provides a different interface to alter strings and work with various sizes of numbers.

I found that implementing this algorithm in various languages gave me a deeper understanding of it's solution. It is also a great way to get familiar with the features and limitations of a language. I hope you enjoyed and learned something interesting.















