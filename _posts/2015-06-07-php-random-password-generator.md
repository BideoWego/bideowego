---
title: PHP Random Password Generator
date: 2015-06-07 00:00:00 -0500
image:
  url: https://s3.amazonaws.com/bw.bideowego/images/php-random-password-generator.jpg
categories: [PHP, Security]
tags: [password, random]
---


A while ago I decided to write a bit of PHP that generates a random password according to common password requirements.

1. lowercase
1. uppercase
1. numeric
1. alpha
1. symbol
1. alpha numeric
1. alpha numeric with dash
1. alpha numeric with underscore
1. alpha numeric with dash and underscore
1. all off the above


Here is the code:


```php
<?php

function random_password($length=8, $type='alpha_numeric', $return_charset = false) {
    $lower = 'abcdefghijklmnopqrstuvwxy';
    $upper = strtoupper($lower);
    $numbers = '1234567890';
    $dash = '-';
    $underscore = '_';
    $symbols = '`~!@#$%^&*()+=[]\\{}|:";\'<>?,./';
    switch ($type) {
        case 'lower':
            $chars = $lower;
            break;
        case 'upper':
            $chars = $upper;
            break;
        case 'numeric':
            $chars = $numbers;
            break;
        case 'alpha':
            $chars = $lower . $upper;
            break;
        case 'symbol':
            $chars = $symbols . $dash . $underscore;
            break;
        case 'alpha_numeric':
            $chars = $lower . $upper . $numbers;
            break;
        case 'alpha_numeric_dash':
            $chars = $lower . $upper . $numbers . $dash;
            break;
        case 'alpha_numeric_underscore':
            $chars = $lower . $upper . $numbers . $underscore;
            break;
        case 'alpha_numeric_dash_underscore':
            $chars = $lower . $upper . $numbers . $underscore . $dash;
            break;
        case 'all':
            $chars = $lower . $upper . $numbers . $underscore . $dash . $symbols;
            break;
        default:
            return null;
    }
    $min = 0;
    $max = strlen($chars) - 1;
    if ($return_charset)
        return $chars;
    if ($length < 1 || $length > 1024)
        return null;
    $password = '';
    for ($i = 0; $i < $length; $i++) {
        $random = mt_rand($min, $max);
        $char = $chars[$random];
        $password .= $char;
    }
    return $password;
}
```


I also began testing the probability of the function generating the same string twice. As the number of tests I ran increased, the resulting average repetitions of the exact string were closer and closer to the actual probability. It works!

View the source on <a href="https://github.com/BideoWego/php-random-password-generator">Github</a>.


## Disclaimer


This is not production ready security here. This is just an exercise. For those interested, [bcrypt](https://en.wikipedia.org/wiki/Bcrypt) is production ready encryption that is implemented in many languages.







