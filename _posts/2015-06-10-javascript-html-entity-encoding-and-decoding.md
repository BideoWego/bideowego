---
title: JavaScript HTML Entity Encoding and Decoding
date: 2015-06-10 00:00:00 -0500
image:
  url: https://s3.amazonaws.com/bw.bideowego/images/javascript-html-entity-encoding-and-decoding.jpg
categories: [JavaScript, HTML]
tags: [html-entities, encoding, decoding]
---


Recently I was presented with the problem of decoding and encoding HTML character entities with JavaScript. The task seems simple! However there are a few gotchas that I'd like to point out as well as show a bit of code that performs the task.

The real work of the code is just these few lines:




```javascript
HtmlEntities.decode = function(string) {
    var entityMap = HtmlEntities.map;
    for (var key in entityMap) {
        var entity = entityMap[key];
        var regex = new RegExp(entity, 'g');
        string = string.replace(regex, key);
    }
    string = string.replace(/&amp;quot;/g, '"');
    string = string.replace(/&amp;amp;/g, '&amp;');
    return string;
}

HtmlEntities.encode = function(string) {
    var entityMap = HtmlEntities.map;
    string = string.replace(/&amp;/g, '&amp;amp;');
    string = string.replace(/"/g, '&amp;quot;');
    for (var key in entityMap) {
        var entity = entityMap[key];
        var regex = new RegExp(key, 'g');
        string = string.replace(regex, entity);
    }
    return string;
}

```




The power of this comes from the map.





```javascript
HtmlEntities.map = {
    "'": "&amp;apos;",
    "&lt;": "&amp;lt;",
    "&gt;": "&amp;gt;",
    " ": "&amp;nbsp;",
    "¡": "&amp;iexcl;",
    "¢": "&amp;cent;",
    "£": "&amp;pound;",
    "¤": "&amp;curren;",
    "¥": "&amp;yen;",
    "¦": "&amp;brvbar;",
    "§": "&amp;sect;",
    "¨": "&amp;uml;",
    "©": "&amp;copy;",
    "ª": "&amp;ordf;",
    "«": "&amp;laquo;",
    "¬": "&amp;not;",
    "®": "&amp;reg;",
    "¯": "&amp;macr;",
    "°": "&amp;deg;",
    "±": "&amp;plusmn;",
    "²": "&amp;sup2;",
    "³": "&amp;sup3;",
    "´": "&amp;acute;",
    "µ": "&amp;micro;",
    "¶": "&amp;para;",
    "·": "&amp;middot;",
    "¸": "&amp;cedil;",
    "¹": "&amp;sup1;",
    "º": "&amp;ordm;",
    "»": "&amp;raquo;",
    "¼": "&amp;frac14;",
    "½": "&amp;frac12;",
    "¾": "&amp;frac34;",
    "¿": "&amp;iquest;",
    "À": "&amp;Agrave;",
    "Á": "&amp;Aacute;",
    "Â": "&amp;Acirc;",
    "Ã": "&amp;Atilde;",
    "Ä": "&amp;Auml;",
    "Å": "&amp;Aring;",
    "Æ": "&amp;AElig;",
    "Ç": "&amp;Ccedil;",
    "È": "&amp;Egrave;",
    "É": "&amp;Eacute;",
    "Ê": "&amp;Ecirc;",
    "Ë": "&amp;Euml;",
    "Ì": "&amp;Igrave;",
    "Í": "&amp;Iacute;",
    "Î": "&amp;Icirc;",
    "Ï": "&amp;Iuml;",
    "Ð": "&amp;ETH;",
    "Ñ": "&amp;Ntilde;",
    "Ò": "&amp;Ograve;",
    "Ó": "&amp;Oacute;",
    "Ô": "&amp;Ocirc;",
    "Õ": "&amp;Otilde;",
    "Ö": "&amp;Ouml;",
    "×": "&amp;times;",
    "Ø": "&amp;Oslash;",
    "Ù": "&amp;Ugrave;",
    "Ú": "&amp;Uacute;",
    "Û": "&amp;Ucirc;",
    "Ü": "&amp;Uuml;",
    "Ý": "&amp;Yacute;",
    "Þ": "&amp;THORN;",
    "ß": "&amp;szlig;",
    "à": "&amp;agrave;",
    "á": "&amp;aacute;",
    "â": "&amp;acirc;",
    "ã": "&amp;atilde;",
    "ä": "&amp;auml;",
    "å": "&amp;aring;",
    "æ": "&amp;aelig;",
    "ç": "&amp;ccedil;",
    "è": "&amp;egrave;",
    "é": "&amp;eacute;",
    "ê": "&amp;ecirc;",
    "ë": "&amp;euml;",
    "ì": "&amp;igrave;",
    "í": "&amp;iacute;",
    "î": "&amp;icirc;",
    "ï": "&amp;iuml;",
    "ð": "&amp;eth;",
    "ñ": "&amp;ntilde;",
    "ò": "&amp;ograve;",
    "ó": "&amp;oacute;",
    "ô": "&amp;ocirc;",
    "õ": "&amp;otilde;",
    "ö": "&amp;ouml;",
    "÷": "&amp;divide;",
    "ø": "&amp;oslash;",
    "ù": "&amp;ugrave;",
    "ú": "&amp;uacute;",
    "û": "&amp;ucirc;",
    "ü": "&amp;uuml;",
    "ý": "&amp;yacute;",
    "þ": "&amp;thorn;",
    "ÿ": "&amp;yuml;",
    "Œ": "&amp;OElig;",
    "œ": "&amp;oelig;",
    "Š": "&amp;Scaron;",
    "š": "&amp;scaron;",
    "Ÿ": "&amp;Yuml;",
    "ƒ": "&amp;fnof;",
    "ˆ": "&amp;circ;",
    "˜": "&amp;tilde;",
    "Α": "&amp;Alpha;",
    "Β": "&amp;Beta;",
    "Γ": "&amp;Gamma;",
    "Δ": "&amp;Delta;",
    "Ε": "&amp;Epsilon;",
    "Ζ": "&amp;Zeta;",
    "Η": "&amp;Eta;",
    "Θ": "&amp;Theta;",
    "Ι": "&amp;Iota;",
    "Κ": "&amp;Kappa;",
    "Λ": "&amp;Lambda;",
    "Μ": "&amp;Mu;",
    "Ν": "&amp;Nu;",
    "Ξ": "&amp;Xi;",
    "Ο": "&amp;Omicron;",
    "Π": "&amp;Pi;",
    "Ρ": "&amp;Rho;",
    "Σ": "&amp;Sigma;",
    "Τ": "&amp;Tau;",
    "Υ": "&amp;Upsilon;",
    "Φ": "&amp;Phi;",
    "Χ": "&amp;Chi;",
    "Ψ": "&amp;Psi;",
    "Ω": "&amp;Omega;",
    "α": "&amp;alpha;",
    "β": "&amp;beta;",
    "γ": "&amp;gamma;",
    "δ": "&amp;delta;",
    "ε": "&amp;epsilon;",
    "ζ": "&amp;zeta;",
    "η": "&amp;eta;",
    "θ": "&amp;theta;",
    "ι": "&amp;iota;",
    "κ": "&amp;kappa;",
    "λ": "&amp;lambda;",
    "μ": "&amp;mu;",
    "ν": "&amp;nu;",
    "ξ": "&amp;xi;",
    "ο": "&amp;omicron;",
    "π": "&amp;pi;",
    "ρ": "&amp;rho;",
    "ς": "&amp;sigmaf;",
    "σ": "&amp;sigma;",
    "τ": "&amp;tau;",
    "υ": "&amp;upsilon;",
    "φ": "&amp;phi;",
    "χ": "&amp;chi;",
    "ψ": "&amp;psi;",
    "ω": "&amp;omega;",
    "ϑ": "&amp;thetasym;",
    "ϒ": "&amp;Upsih;",
    "ϖ": "&amp;piv;",
    "–": "&amp;ndash;",
    "—": "&amp;mdash;",
    "‘": "&amp;lsquo;",
    "’": "&amp;rsquo;",
    "‚": "&amp;sbquo;",
    "“": "&amp;ldquo;",
    "”": "&amp;rdquo;",
    "„": "&amp;bdquo;",
    "†": "&amp;dagger;",
    "‡": "&amp;Dagger;",
    "•": "&amp;bull;",
    "…": "&amp;hellip;",
    "‰": "&amp;permil;",
    "′": "&amp;prime;",
    "″": "&amp;Prime;",
    "‹": "&amp;lsaquo;",
    "›": "&amp;rsaquo;",
    "‾": "&amp;oline;",
    "⁄": "&amp;frasl;",
    "€": "&amp;euro;",
    "ℑ": "&amp;image;",
    "℘": "&amp;weierp;",
    "ℜ": "&amp;real;",
    "™": "&amp;trade;",
    "ℵ": "&amp;alefsym;",
    "←": "&amp;larr;",
    "↑": "&amp;uarr;",
    "→": "&amp;rarr;",
    "↓": "&amp;darr;",
    "↔": "&amp;harr;",
    "↵": "&amp;crarr;",
    "⇐": "&amp;lArr;",
    "⇑": "&amp;UArr;",
    "⇒": "&amp;rArr;",
    "⇓": "&amp;dArr;",
    "⇔": "&amp;hArr;",
    "∀": "&amp;forall;",
    "∂": "&amp;part;",
    "∃": "&amp;exist;",
    "∅": "&amp;empty;",
    "∇": "&amp;nabla;",
    "∈": "&amp;isin;",
    "∉": "&amp;notin;",
    "∋": "&amp;ni;",
    "∏": "&amp;prod;",
    "∑": "&amp;sum;",
    "−": "&amp;minus;",
    "∗": "&amp;lowast;",
    "√": "&amp;radic;",
    "∝": "&amp;prop;",
    "∞": "&amp;infin;",
    "∠": "&amp;ang;",
    "∧": "&amp;and;",
    "∨": "&amp;or;",
    "∩": "&amp;cap;",
    "∪": "&amp;cup;",
    "∫": "&amp;int;",
    "∴": "&amp;there4;",
    "∼": "&amp;sim;",
    "≅": "&amp;cong;",
    "≈": "&amp;asymp;",
    "≠": "&amp;ne;",
    "≡": "&amp;equiv;",
    "≤": "&amp;le;",
    "≥": "&amp;ge;",
    "⊂": "&amp;sub;",
    "⊃": "&amp;sup;",
    "⊄": "&amp;nsub;",
    "⊆": "&amp;sube;",
    "⊇": "&amp;supe;",
    "⊕": "&amp;oplus;",
    "⊗": "&amp;otimes;",
    "⊥": "&amp;perp;",
    "⋅": "&amp;sdot;",
    "⌈": "&amp;lceil;",
    "⌉": "&amp;rceil;",
    "⌊": "&amp;lfloor;",
    "⌋": "&amp;rfloor;",
    "⟨": "&amp;lang;",
    "⟩": "&amp;rang;",
    "◊": "&amp;loz;",
    "♠": "&amp;spades;",
    "♣": "&amp;clubs;",
    "♥": "&amp;hearts;",
    "♦": "&amp;diams;"
};
```



Note how the character entity is used as the key and the HTML entity is the value of the map. This allows for elegant pairing of the two values and easy access in a loop.

Now for the fun part! The replacement of text via <a href="http://www.w3schools.com/jsref/jsref_obj_regexp.asp" target="_blank">Regular Expressions</a>. The character or entity is replaced in the given text via a global regular expression. This means that every instance of the given string will be replaced with another given string.

In order to properly encode and decode characters we must take into consideration a few gotchas:


1. The `"` and `&` cannot exist in the map
1. The `&` must be encoded first and decoded last
1. The " must be encoded after the &amp; and decoded before the &amp;


Why you ask?

First the `"` cannot be the key of the JavaScript map object. All of the other characters are surrounded by double quotes. While the ' can be used as a key if surrounded by double quotes, the quotes surrounding the key cannot be changed just for one key value pair. This means a choice must be made, exclude the single or double quote? I chose the double.

Next the `&` cannot exist in the map because it must be handled specially. If the loop is running and all of the `&`'s are encoded after other characters have been encoded, then the encoding of the `&`'s will duplicate HTML entities that were not meant to be created. Example:


1. Raw text is `'This is < that & done!'`
1. We encode the `<` into `&amp;lt;`
1. Next when we go to encode the `&amp;` to be `&amp;amp;` we also find the `&amp;` in `&amp;lt;`
1. The result is `'This is &amp;amp;lt; that &amp;amp; done!'`
1. The encode and decode of the same text will now differ


To avoid this we first encode all of the `&` with


```javascript
string = string.replace(/&amp;/g, '&amp;amp;');
```


Now that we don't have to worry about duplicating `&amp;amp;` all over the place we can safely continue by encoding the `"`.



```javascript
string = string.replace(/"/g, '&amp;quot;');
```


With the special cases out of the way we can continue with the rest of the map.


```javascript
for (var key in entityMap) {
    var entity = entityMap[key];
    var regex = new RegExp(key, 'g');
    string = string.replace(regex, entity);
}
return string;
```

The process is reversed upon decode:


```javascript
for (var key in entityMap) {
    var entity = entityMap[key];
    var regex = new RegExp(entity, 'g');
    string = string.replace(regex, key);
}
string = string.replace(/&amp;quot;/g, '"');
string = string.replace(/&amp;amp;/g, '&amp;');
```


If you want to mess around with an example here it is on <a href="https://jsfiddle.net/BideoWego/muuvvof8/">JS Fiddle</a>.

View the project on <a href="https://github.com/BideoWego/html-entities-js" target="_blank">GitHub</a>.










