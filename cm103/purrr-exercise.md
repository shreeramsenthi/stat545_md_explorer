---
title: "cm103 Worksheet"
output: github_document
---


```r
suppressPackageStartupMessages(library(tidyverse)) # Loads purrr, too
library(repurrrsive) # Contains data examples
library(listviewer) # For viewing JSON/lists interactively
```

## Resources

This week, we'll be drawing from [Jenny Bryan's `purrr` tutorial](https://jennybc.github.io/purrr-tutorial/). Specifically:

- The [`map` tutorial](https://jennybc.github.io/purrr-tutorial/ls01_map-name-position-shortcuts.html)
- The [GitHub users tutorial](https://jennybc.github.io/purrr-tutorial/ls02_map-extraction-advanced.html) is similar.

In addition:

- Do you feel that you need a refresher on lists and vectors in R? Check out the [Vectors and Lists](https://jennybc.github.io/purrr-tutorial/bk00_vectors-and-lists.html) part of the tutorial.
- Are you familiar with the `apply` family of functions in Base R? You might find Jenny's ["Relationship to base and plyr functions"](https://jennybc.github.io/purrr-tutorial/bk01_base-functions.html) great for bridging the gap to `purrr`.


## Review Vectors and Lists

Vectors:

- hold multiple entries of the same type.
- coerced to the least-informative data type in the vector.
- subset with single square brackets

Lists:

- hold multiple entries of anything.
- no entries are coerced (as a result of being able to hold anything)
- subset with `[`, `[[`, or

## Review Vectorization

= element-wise application of a function.

Examples:


```r
(1:10) ^ 2
```

```
##  [1]   1   4   9  16  25  36  49  64  81 100
```


```r
(1:10) * (1:2)
```

```
##  [1]  1  4  3  8  5 12  7 16  9 20
```


```r
commute <- c(40, 20, 35, 15)
person <- c("Parveen", "Leo", "Shawn", "Emmotions")
paste0(person, " takes ", commute, " minutes to commute to work.") ==  str_c(person, " takes ", commute, " minutes to commute to work.")
```

```
## [1] TRUE TRUE TRUE TRUE
```

## `purrr`

`purrr` is great when vectorization does not apply!

Particularly useful if your data is in JSON format.

Example:

1. Explore the `wesanderson` list (comes with `repurrrsive` package). Hint: `str()` might help. It's a list of vectors.
2. Use what you know about R to write code that extracts a vector of the first elements of each vector contained in `wesanderson`.


```r
x <- character(0)

for(i in 1:length(wesanderson)) x <- c(x, wesanderson[[i]][1])

x
```

```
##  [1] "#F1BB7B" "#F3DF6C" "#899DA4" "#798E87" "#D8B70A" "#9A8822" "#E6A0C4"
##  [8] "#85D4E3" "#446455" "#3B9AB2" "#DD8D29" "#FF0000" "#E1BD6D" "#A42820"
## [15] "#ECCBAE"
```

`str()` is not always useful! Try checking the structure of `got_chars` (= Game of Thrones characters):


```r
str(got_chars)
```

```
## List of 30
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/1022"
##   ..$ id         : int 1022
##   ..$ name       : chr "Theon Greyjoy"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr "Ironborn"
##   ..$ born       : chr "In 278 AC or 279 AC, at Pyke"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr [1:3] "Prince of Winterfell" "Captain of Sea Bitch" "Lord of the Iron Islands (by law of the green lands)"
##   ..$ aliases    : chr [1:4] "Prince of Fools" "Theon Turncloak" "Reek" "Theon Kinslayer"
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: chr "House Greyjoy of Pyke"
##   ..$ books      : chr [1:3] "A Game of Thrones" "A Storm of Swords" "A Feast for Crows"
##   ..$ povBooks   : chr [1:2] "A Clash of Kings" "A Dance with Dragons"
##   ..$ tvSeries   : chr [1:6] "Season 1" "Season 2" "Season 3" "Season 4" ...
##   ..$ playedBy   : chr "Alfie Allen"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/1052"
##   ..$ id         : int 1052
##   ..$ name       : chr "Tyrion Lannister"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr ""
##   ..$ born       : chr "In 273 AC, at Casterly Rock"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr [1:2] "Acting Hand of the King (former)" "Master of Coin (former)"
##   ..$ aliases    : chr [1:11] "The Imp" "Halfman" "The boyman" "Giant of Lannister" ...
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr "https://www.anapioficeandfire.com/api/characters/2044"
##   ..$ allegiances: chr "House Lannister of Casterly Rock"
##   ..$ books      : chr [1:2] "A Feast for Crows" "The World of Ice and Fire"
##   ..$ povBooks   : chr [1:4] "A Game of Thrones" "A Clash of Kings" "A Storm of Swords" "A Dance with Dragons"
##   ..$ tvSeries   : chr [1:6] "Season 1" "Season 2" "Season 3" "Season 4" ...
##   ..$ playedBy   : chr "Peter Dinklage"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/1074"
##   ..$ id         : int 1074
##   ..$ name       : chr "Victarion Greyjoy"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr "Ironborn"
##   ..$ born       : chr "In 268 AC or before, at Pyke"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr [1:2] "Lord Captain of the Iron Fleet" "Master of the Iron Victory"
##   ..$ aliases    : chr "The Iron Captain"
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: chr "House Greyjoy of Pyke"
##   ..$ books      : chr [1:3] "A Game of Thrones" "A Clash of Kings" "A Storm of Swords"
##   ..$ povBooks   : chr [1:2] "A Feast for Crows" "A Dance with Dragons"
##   ..$ tvSeries   : chr ""
##   ..$ playedBy   : chr ""
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/1109"
##   ..$ id         : int 1109
##   ..$ name       : chr "Will"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr ""
##   ..$ born       : chr ""
##   ..$ died       : chr "In 297 AC, at Haunted Forest"
##   ..$ alive      : logi FALSE
##   ..$ titles     : chr ""
##   ..$ aliases    : chr ""
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: list()
##   ..$ books      : chr "A Clash of Kings"
##   ..$ povBooks   : chr "A Game of Thrones"
##   ..$ tvSeries   : chr ""
##   ..$ playedBy   : chr "Bronson Webb"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/1166"
##   ..$ id         : int 1166
##   ..$ name       : chr "Areo Hotah"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr "Norvoshi"
##   ..$ born       : chr "In 257 AC or before, at Norvos"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr "Captain of the Guard at Sunspear"
##   ..$ aliases    : chr ""
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: chr "House Nymeros Martell of Sunspear"
##   ..$ books      : chr [1:3] "A Game of Thrones" "A Clash of Kings" "A Storm of Swords"
##   ..$ povBooks   : chr [1:2] "A Feast for Crows" "A Dance with Dragons"
##   ..$ tvSeries   : chr [1:2] "Season 5" "Season 6"
##   ..$ playedBy   : chr "DeObia Oparei"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/1267"
##   ..$ id         : int 1267
##   ..$ name       : chr "Chett"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr ""
##   ..$ born       : chr "At Hag's Mire"
##   ..$ died       : chr "In 299 AC, at Fist of the First Men"
##   ..$ alive      : logi FALSE
##   ..$ titles     : chr ""
##   ..$ aliases    : chr ""
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: list()
##   ..$ books      : chr [1:2] "A Game of Thrones" "A Clash of Kings"
##   ..$ povBooks   : chr "A Storm of Swords"
##   ..$ tvSeries   : chr ""
##   ..$ playedBy   : chr ""
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/1295"
##   ..$ id         : int 1295
##   ..$ name       : chr "Cressen"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr ""
##   ..$ born       : chr "In 219 AC or 220 AC"
##   ..$ died       : chr "In 299 AC, at Dragonstone"
##   ..$ alive      : logi FALSE
##   ..$ titles     : chr "Maester"
##   ..$ aliases    : chr ""
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: list()
##   ..$ books      : chr [1:2] "A Storm of Swords" "A Feast for Crows"
##   ..$ povBooks   : chr "A Clash of Kings"
##   ..$ tvSeries   : chr "Season 2"
##   ..$ playedBy   : chr "Oliver Ford"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/130"
##   ..$ id         : int 130
##   ..$ name       : chr "Arianne Martell"
##   ..$ gender     : chr "Female"
##   ..$ culture    : chr "Dornish"
##   ..$ born       : chr "In 276 AC, at Sunspear"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr "Princess of Dorne"
##   ..$ aliases    : chr ""
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: chr "House Nymeros Martell of Sunspear"
##   ..$ books      : chr [1:4] "A Game of Thrones" "A Clash of Kings" "A Storm of Swords" "A Dance with Dragons"
##   ..$ povBooks   : chr "A Feast for Crows"
##   ..$ tvSeries   : chr ""
##   ..$ playedBy   : chr ""
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/1303"
##   ..$ id         : int 1303
##   ..$ name       : chr "Daenerys Targaryen"
##   ..$ gender     : chr "Female"
##   ..$ culture    : chr "Valyrian"
##   ..$ born       : chr "In 284 AC, at Dragonstone"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr [1:5] "Queen of the Andals and the Rhoynar and the First Men, Lord of the Seven Kingdoms" "Khaleesi of the Great Grass Sea" "Breaker of Shackles/Chains" "Queen of Meereen" ...
##   ..$ aliases    : chr [1:11] "Dany" "Daenerys Stormborn" "The Unburnt" "Mother of Dragons" ...
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr "https://www.anapioficeandfire.com/api/characters/1346"
##   ..$ allegiances: chr "House Targaryen of King's Landing"
##   ..$ books      : chr "A Feast for Crows"
##   ..$ povBooks   : chr [1:4] "A Game of Thrones" "A Clash of Kings" "A Storm of Swords" "A Dance with Dragons"
##   ..$ tvSeries   : chr [1:6] "Season 1" "Season 2" "Season 3" "Season 4" ...
##   ..$ playedBy   : chr "Emilia Clarke"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/1319"
##   ..$ id         : int 1319
##   ..$ name       : chr "Davos Seaworth"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr "Westeros"
##   ..$ born       : chr "In 260 AC or before, at King's Landing"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr [1:4] "Ser" "Lord of the Rainwood" "Admiral of the Narrow Sea" "Hand of the King"
##   ..$ aliases    : chr [1:5] "Onion Knight" "Davos Shorthand" "Ser Onions" "Onion Lord" ...
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr "https://www.anapioficeandfire.com/api/characters/1676"
##   ..$ allegiances: chr [1:2] "House Baratheon of Dragonstone" "House Seaworth of Cape Wrath"
##   ..$ books      : chr "A Feast for Crows"
##   ..$ povBooks   : chr [1:3] "A Clash of Kings" "A Storm of Swords" "A Dance with Dragons"
##   ..$ tvSeries   : chr [1:5] "Season 2" "Season 3" "Season 4" "Season 5" ...
##   ..$ playedBy   : chr "Liam Cunningham"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/148"
##   ..$ id         : int 148
##   ..$ name       : chr "Arya Stark"
##   ..$ gender     : chr "Female"
##   ..$ culture    : chr "Northmen"
##   ..$ born       : chr "In 289 AC, at Winterfell"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr "Princess"
##   ..$ aliases    : chr [1:16] "Arya Horseface" "Arya Underfoot" "Arry" "Lumpyface" ...
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: chr "House Stark of Winterfell"
##   ..$ books      : list()
##   ..$ povBooks   : chr [1:5] "A Game of Thrones" "A Clash of Kings" "A Storm of Swords" "A Feast for Crows" ...
##   ..$ tvSeries   : chr [1:6] "Season 1" "Season 2" "Season 3" "Season 4" ...
##   ..$ playedBy   : chr "Maisie Williams"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/149"
##   ..$ id         : int 149
##   ..$ name       : chr "Arys Oakheart"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr "Reach"
##   ..$ born       : chr "At Old Oak"
##   ..$ died       : chr "In 300 AC, at the Greenblood"
##   ..$ alive      : logi FALSE
##   ..$ titles     : chr "Ser"
##   ..$ aliases    : chr ""
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: chr "House Oakheart of Old Oak"
##   ..$ books      : chr [1:4] "A Game of Thrones" "A Clash of Kings" "A Storm of Swords" "A Dance with Dragons"
##   ..$ povBooks   : chr "A Feast for Crows"
##   ..$ tvSeries   : chr ""
##   ..$ playedBy   : chr ""
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/150"
##   ..$ id         : int 150
##   ..$ name       : chr "Asha Greyjoy"
##   ..$ gender     : chr "Female"
##   ..$ culture    : chr "Ironborn"
##   ..$ born       : chr "In 275 AC or 276 AC, at Pyke"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr [1:3] "Princess" "Captain of the Black Wind" "Conqueror of Deepwood Motte"
##   ..$ aliases    : chr [1:2] "Esgred" "The Kraken's Daughter"
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr "https://www.anapioficeandfire.com/api/characters/1372"
##   ..$ allegiances: chr [1:2] "House Greyjoy of Pyke" "House Ironmaker"
##   ..$ books      : chr [1:2] "A Game of Thrones" "A Clash of Kings"
##   ..$ povBooks   : chr [1:2] "A Feast for Crows" "A Dance with Dragons"
##   ..$ tvSeries   : chr [1:3] "Season 2" "Season 3" "Season 4"
##   ..$ playedBy   : chr "Gemma Whelan"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/168"
##   ..$ id         : int 168
##   ..$ name       : chr "Barristan Selmy"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr "Westeros"
##   ..$ born       : chr "In 237 AC"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr [1:2] "Ser" "Hand of the Queen"
##   ..$ aliases    : chr [1:5] "Barristan the Bold" "Arstan Whitebeard" "Ser Grandfather" "Barristan the Old" ...
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: chr [1:2] "House Selmy of Harvest Hall" "House Targaryen of King's Landing"
##   ..$ books      : chr [1:5] "A Game of Thrones" "A Clash of Kings" "A Storm of Swords" "A Feast for Crows" ...
##   ..$ povBooks   : chr "A Dance with Dragons"
##   ..$ tvSeries   : chr [1:4] "Season 1" "Season 3" "Season 4" "Season 5"
##   ..$ playedBy   : chr "Ian McElhinney"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/2066"
##   ..$ id         : int 2066
##   ..$ name       : chr "Varamyr"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr "Free Folk"
##   ..$ born       : chr "At a village Beyond the Wall"
##   ..$ died       : chr "In 300 AC, at a village Beyond the Wall"
##   ..$ alive      : logi FALSE
##   ..$ titles     : chr ""
##   ..$ aliases    : chr [1:3] "Varamyr Sixskins" "Haggon" "Lump"
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: list()
##   ..$ books      : chr "A Storm of Swords"
##   ..$ povBooks   : chr "A Dance with Dragons"
##   ..$ tvSeries   : chr ""
##   ..$ playedBy   : chr ""
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/208"
##   ..$ id         : int 208
##   ..$ name       : chr "Brandon Stark"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr "Northmen"
##   ..$ born       : chr "In 290 AC, at Winterfell"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr "Prince of Winterfell"
##   ..$ aliases    : chr [1:3] "Bran" "Bran the Broken" "The Winged Wolf"
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: chr "House Stark of Winterfell"
##   ..$ books      : chr "A Feast for Crows"
##   ..$ povBooks   : chr [1:4] "A Game of Thrones" "A Clash of Kings" "A Storm of Swords" "A Dance with Dragons"
##   ..$ tvSeries   : chr [1:5] "Season 1" "Season 2" "Season 3" "Season 4" ...
##   ..$ playedBy   : chr "Isaac Hempstead-Wright"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/216"
##   ..$ id         : int 216
##   ..$ name       : chr "Brienne of Tarth"
##   ..$ gender     : chr "Female"
##   ..$ culture    : chr ""
##   ..$ born       : chr "In 280 AC"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr ""
##   ..$ aliases    : chr [1:3] "The Maid of Tarth" "Brienne the Beauty" "Brienne the Blue"
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: chr [1:3] "House Baratheon of Storm's End" "House Stark of Winterfell" "House Tarth of Evenfall Hall"
##   ..$ books      : chr [1:3] "A Clash of Kings" "A Storm of Swords" "A Dance with Dragons"
##   ..$ povBooks   : chr "A Feast for Crows"
##   ..$ tvSeries   : chr [1:5] "Season 2" "Season 3" "Season 4" "Season 5" ...
##   ..$ playedBy   : chr "Gwendoline Christie"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/232"
##   ..$ id         : int 232
##   ..$ name       : chr "Catelyn Stark"
##   ..$ gender     : chr "Female"
##   ..$ culture    : chr "Rivermen"
##   ..$ born       : chr "In 264 AC, at Riverrun"
##   ..$ died       : chr "In 299 AC, at the Twins"
##   ..$ alive      : logi FALSE
##   ..$ titles     : chr "Lady of Winterfell"
##   ..$ aliases    : chr [1:5] "Catelyn Tully" "Lady Stoneheart" "The Silent Sistet" "Mother Mercilesr" ...
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr "https://www.anapioficeandfire.com/api/characters/339"
##   ..$ allegiances: chr [1:2] "House Stark of Winterfell" "House Tully of Riverrun"
##   ..$ books      : chr [1:2] "A Feast for Crows" "A Dance with Dragons"
##   ..$ povBooks   : chr [1:3] "A Game of Thrones" "A Clash of Kings" "A Storm of Swords"
##   ..$ tvSeries   : chr [1:3] "Season 1" "Season 2" "Season 3"
##   ..$ playedBy   : chr "Michelle Fairley"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/238"
##   ..$ id         : int 238
##   ..$ name       : chr "Cersei Lannister"
##   ..$ gender     : chr "Female"
##   ..$ culture    : chr "Westerman"
##   ..$ born       : chr "In 266 AC, at Casterly Rock"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr [1:5] "Light of the West" "Queen Dowager" "Protector of the Realm" "Lady of Casterly Rock" ...
##   ..$ aliases    : list()
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr "https://www.anapioficeandfire.com/api/characters/901"
##   ..$ allegiances: chr "House Lannister of Casterly Rock"
##   ..$ books      : chr [1:3] "A Game of Thrones" "A Clash of Kings" "A Storm of Swords"
##   ..$ povBooks   : chr [1:2] "A Feast for Crows" "A Dance with Dragons"
##   ..$ tvSeries   : chr [1:6] "Season 1" "Season 2" "Season 3" "Season 4" ...
##   ..$ playedBy   : chr "Lena Headey"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/339"
##   ..$ id         : int 339
##   ..$ name       : chr "Eddard Stark"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr "Northmen"
##   ..$ born       : chr "In 263 AC, at Winterfell"
##   ..$ died       : chr "In 299 AC, at Great Sept of Baelor in King's Landing"
##   ..$ alive      : logi FALSE
##   ..$ titles     : chr [1:5] "Lord of Winterfell" "Warden of the North" "Hand of the King" "Protector of the Realm" ...
##   ..$ aliases    : chr [1:3] "Ned" "The Ned" "The Quiet Wolf"
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr "https://www.anapioficeandfire.com/api/characters/232"
##   ..$ allegiances: chr "House Stark of Winterfell"
##   ..$ books      : chr [1:5] "A Clash of Kings" "A Storm of Swords" "A Feast for Crows" "A Dance with Dragons" ...
##   ..$ povBooks   : chr "A Game of Thrones"
##   ..$ tvSeries   : chr [1:2] "Season 1" "Season 6"
##   ..$ playedBy   : chr [1:3] "Sean Bean" "Sebastian Croft" "Robert Aramayo"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/529"
##   ..$ id         : int 529
##   ..$ name       : chr "Jaime Lannister"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr "Westerlands"
##   ..$ born       : chr "In 266 AC, at Casterly Rock"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr [1:3] "Ser" "Lord Commander of the Kingsguard" "Warden of the East (formerly)"
##   ..$ aliases    : chr [1:4] "The Kingslayer" "The Lion of Lannister" "The Young Lion" "Cripple"
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: chr "House Lannister of Casterly Rock"
##   ..$ books      : chr [1:2] "A Game of Thrones" "A Clash of Kings"
##   ..$ povBooks   : chr [1:3] "A Storm of Swords" "A Feast for Crows" "A Dance with Dragons"
##   ..$ tvSeries   : chr [1:5] "Season 1" "Season 2" "Season 3" "Season 4" ...
##   ..$ playedBy   : chr "Nikolaj Coster-Waldau"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/576"
##   ..$ id         : int 576
##   ..$ name       : chr "Jon Connington"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr "Stormlands"
##   ..$ born       : chr "In or between 263 AC and 265 AC"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr [1:3] "Lord of Griffin's Roost" "Hand of the King" "Hand of the True King"
##   ..$ aliases    : chr "Griffthe Mad King's Hand"
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: chr [1:2] "House Connington of Griffin's Roost" "House Targaryen of King's Landing"
##   ..$ books      : chr [1:3] "A Storm of Swords" "A Feast for Crows" "The World of Ice and Fire"
##   ..$ povBooks   : chr "A Dance with Dragons"
##   ..$ tvSeries   : chr ""
##   ..$ playedBy   : chr ""
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/583"
##   ..$ id         : int 583
##   ..$ name       : chr "Jon Snow"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr "Northmen"
##   ..$ born       : chr "In 283 AC"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr "Lord Commander of the Night's Watch"
##   ..$ aliases    : chr [1:8] "Lord Snow" "Ned Stark's Bastard" "The Snow of Winterfell" "The Crow-Come-Over" ...
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: chr "House Stark of Winterfell"
##   ..$ books      : chr "A Feast for Crows"
##   ..$ povBooks   : chr [1:4] "A Game of Thrones" "A Clash of Kings" "A Storm of Swords" "A Dance with Dragons"
##   ..$ tvSeries   : chr [1:6] "Season 1" "Season 2" "Season 3" "Season 4" ...
##   ..$ playedBy   : chr "Kit Harington"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/60"
##   ..$ id         : int 60
##   ..$ name       : chr "Aeron Greyjoy"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr "Ironborn"
##   ..$ born       : chr "In or between 269 AC and 273 AC, at Pyke"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr [1:2] "Priest of the Drowned God" "Captain of the Golden Storm (formerly)"
##   ..$ aliases    : chr [1:2] "The Damphair" "Aeron Damphair"
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: chr "House Greyjoy of Pyke"
##   ..$ books      : chr [1:4] "A Game of Thrones" "A Clash of Kings" "A Storm of Swords" "A Dance with Dragons"
##   ..$ povBooks   : chr "A Feast for Crows"
##   ..$ tvSeries   : chr "Season 6"
##   ..$ playedBy   : chr "Michael Feast"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/605"
##   ..$ id         : int 605
##   ..$ name       : chr "Kevan Lannister"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr ""
##   ..$ born       : chr "In 244 AC"
##   ..$ died       : chr "In 300 AC, at King's Landing"
##   ..$ alive      : logi FALSE
##   ..$ titles     : chr [1:4] "Ser" "Master of laws" "Lord Regent" "Protector of the Realm"
##   ..$ aliases    : chr ""
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr "https://www.anapioficeandfire.com/api/characters/327"
##   ..$ allegiances: chr "House Lannister of Casterly Rock"
##   ..$ books      : chr [1:4] "A Game of Thrones" "A Clash of Kings" "A Storm of Swords" "A Feast for Crows"
##   ..$ povBooks   : chr "A Dance with Dragons"
##   ..$ tvSeries   : chr [1:4] "Season 1" "Season 2" "Season 5" "Season 6"
##   ..$ playedBy   : chr "Ian Gelder"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/743"
##   ..$ id         : int 743
##   ..$ name       : chr "Melisandre"
##   ..$ gender     : chr "Female"
##   ..$ culture    : chr "Asshai"
##   ..$ born       : chr "At Unknown"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr ""
##   ..$ aliases    : chr [1:5] "The Red Priestess" "The Red Woman" "The King's Red Shadow" "Lady Red" ...
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: list()
##   ..$ books      : chr [1:3] "A Clash of Kings" "A Storm of Swords" "A Feast for Crows"
##   ..$ povBooks   : chr "A Dance with Dragons"
##   ..$ tvSeries   : chr [1:5] "Season 2" "Season 3" "Season 4" "Season 5" ...
##   ..$ playedBy   : chr "Carice van Houten"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/751"
##   ..$ id         : int 751
##   ..$ name       : chr "Merrett Frey"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr "Rivermen"
##   ..$ born       : chr "In 262 AC"
##   ..$ died       : chr "In 300 AC, at Near Oldstones"
##   ..$ alive      : logi FALSE
##   ..$ titles     : chr ""
##   ..$ aliases    : chr "Merrett Muttonhead"
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr "https://www.anapioficeandfire.com/api/characters/712"
##   ..$ allegiances: chr "House Frey of the Crossing"
##   ..$ books      : chr [1:4] "A Game of Thrones" "A Clash of Kings" "A Feast for Crows" "A Dance with Dragons"
##   ..$ povBooks   : chr "A Storm of Swords"
##   ..$ tvSeries   : chr ""
##   ..$ playedBy   : chr ""
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/844"
##   ..$ id         : int 844
##   ..$ name       : chr "Quentyn Martell"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr "Dornish"
##   ..$ born       : chr "In 281 AC, at Sunspear, Dorne"
##   ..$ died       : chr "In 300 AC, at Meereen"
##   ..$ alive      : logi FALSE
##   ..$ titles     : chr "Prince"
##   ..$ aliases    : chr [1:4] "Frog" "Prince Frog" "The prince who came too late" "The Dragonrider"
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: chr "House Nymeros Martell of Sunspear"
##   ..$ books      : chr [1:4] "A Game of Thrones" "A Clash of Kings" "A Storm of Swords" "A Feast for Crows"
##   ..$ povBooks   : chr "A Dance with Dragons"
##   ..$ tvSeries   : chr ""
##   ..$ playedBy   : chr ""
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/954"
##   ..$ id         : int 954
##   ..$ name       : chr "Samwell Tarly"
##   ..$ gender     : chr "Male"
##   ..$ culture    : chr "Andal"
##   ..$ born       : chr "In 283 AC, at Horn Hill"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr ""
##   ..$ aliases    : chr [1:7] "Sam" "Ser Piggy" "Prince Pork-chop" "Lady Piggy" ...
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr ""
##   ..$ allegiances: chr "House Tarly of Horn Hill"
##   ..$ books      : chr [1:3] "A Game of Thrones" "A Clash of Kings" "A Dance with Dragons"
##   ..$ povBooks   : chr [1:2] "A Storm of Swords" "A Feast for Crows"
##   ..$ tvSeries   : chr [1:6] "Season 1" "Season 2" "Season 3" "Season 4" ...
##   ..$ playedBy   : chr "John Bradley-West"
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/957"
##   ..$ id         : int 957
##   ..$ name       : chr "Sansa Stark"
##   ..$ gender     : chr "Female"
##   ..$ culture    : chr "Northmen"
##   ..$ born       : chr "In 286 AC, at Winterfell"
##   ..$ died       : chr ""
##   ..$ alive      : logi TRUE
##   ..$ titles     : chr "Princess"
##   ..$ aliases    : chr [1:3] "Little bird" "Alayne Stone" "Jonquil"
##   ..$ father     : chr ""
##   ..$ mother     : chr ""
##   ..$ spouse     : chr "https://www.anapioficeandfire.com/api/characters/1052"
##   ..$ allegiances: chr [1:2] "House Baelish of Harrenhal" "House Stark of Winterfell"
##   ..$ books      : chr "A Dance with Dragons"
##   ..$ povBooks   : chr [1:4] "A Game of Thrones" "A Clash of Kings" "A Storm of Swords" "A Feast for Crows"
##   ..$ tvSeries   : chr [1:6] "Season 1" "Season 2" "Season 3" "Season 4" ...
##   ..$ playedBy   : chr "Sophie Turner"
```


## Exploring lists

1. `str()`: embrace `list.len` and `max.level`


```r
str(got_chars, list.len=4, max.level = 2)
```

```
## List of 30
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/1022"
##   ..$ id         : int 1022
##   ..$ name       : chr "Theon Greyjoy"
##   ..$ gender     : chr "Male"
##   .. [list output truncated]
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/1052"
##   ..$ id         : int 1052
##   ..$ name       : chr "Tyrion Lannister"
##   ..$ gender     : chr "Male"
##   .. [list output truncated]
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/1074"
##   ..$ id         : int 1074
##   ..$ name       : chr "Victarion Greyjoy"
##   ..$ gender     : chr "Male"
##   .. [list output truncated]
##  $ :List of 18
##   ..$ url        : chr "https://www.anapioficeandfire.com/api/characters/1109"
##   ..$ id         : int 1109
##   ..$ name       : chr "Will"
##   ..$ gender     : chr "Male"
##   .. [list output truncated]
##   [list output truncated]
```

```r
str(got_chars[[1]])
```

```
## List of 18
##  $ url        : chr "https://www.anapioficeandfire.com/api/characters/1022"
##  $ id         : int 1022
##  $ name       : chr "Theon Greyjoy"
##  $ gender     : chr "Male"
##  $ culture    : chr "Ironborn"
##  $ born       : chr "In 278 AC or 279 AC, at Pyke"
##  $ died       : chr ""
##  $ alive      : logi TRUE
##  $ titles     : chr [1:3] "Prince of Winterfell" "Captain of Sea Bitch" "Lord of the Iron Islands (by law of the green lands)"
##  $ aliases    : chr [1:4] "Prince of Fools" "Theon Turncloak" "Reek" "Theon Kinslayer"
##  $ father     : chr ""
##  $ mother     : chr ""
##  $ spouse     : chr ""
##  $ allegiances: chr "House Greyjoy of Pyke"
##  $ books      : chr [1:3] "A Game of Thrones" "A Storm of Swords" "A Feast for Crows"
##  $ povBooks   : chr [1:2] "A Clash of Kings" "A Dance with Dragons"
##  $ tvSeries   : chr [1:6] "Season 1" "Season 2" "Season 3" "Season 4" ...
##  $ playedBy   : chr "Alfie Allen"
```

2. Interactive exploration: `View()` and `listviewer::jsonedit(..., mode = "view")`


```r
View(got_chars)
```

```
## Error in (function (..., row.names = NULL, check.rows = FALSE, check.names = TRUE, : arguments imply differing number of rows: 1, 3, 4, 2, 6
```

```r
jsonedit(got_chars, mode="view")
```

![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-8-1.png)

3. Don't be afraid to check out a subset! `names()` comes in handy, too.


```r
str(got_chars[[1]])
```

```
## List of 18
##  $ url        : chr "https://www.anapioficeandfire.com/api/characters/1022"
##  $ id         : int 1022
##  $ name       : chr "Theon Greyjoy"
##  $ gender     : chr "Male"
##  $ culture    : chr "Ironborn"
##  $ born       : chr "In 278 AC or 279 AC, at Pyke"
##  $ died       : chr ""
##  $ alive      : logi TRUE
##  $ titles     : chr [1:3] "Prince of Winterfell" "Captain of Sea Bitch" "Lord of the Iron Islands (by law of the green lands)"
##  $ aliases    : chr [1:4] "Prince of Fools" "Theon Turncloak" "Reek" "Theon Kinslayer"
##  $ father     : chr ""
##  $ mother     : chr ""
##  $ spouse     : chr ""
##  $ allegiances: chr "House Greyjoy of Pyke"
##  $ books      : chr [1:3] "A Game of Thrones" "A Storm of Swords" "A Feast for Crows"
##  $ povBooks   : chr [1:2] "A Clash of Kings" "A Dance with Dragons"
##  $ tvSeries   : chr [1:6] "Season 1" "Season 2" "Season 3" "Season 4" ...
##  $ playedBy   : chr "Alfie Allen"
```

```r
names(got_chars[[1]])
```

```
##  [1] "url"         "id"          "name"        "gender"      "culture"    
##  [6] "born"        "died"        "alive"       "titles"      "aliases"    
## [11] "father"      "mother"      "spouse"      "allegiances" "books"      
## [16] "povBooks"    "tvSeries"    "playedBy"
```


## Exploring `purrr` fundamentals

Apply a function to each element in a list/vector with `map`.

General usage: `purrr::map(VECTOR_OR_LIST, YOUR_FUNCTION)`

Note:

- `map` always returns a list.
- `YOUR_FUNCTION` can return anything!

Toy example 1: without using vectorization, take the square root of the following vector:


```r
x <- 1:10
sqrt(x)
```

```
##  [1] 1.000000 1.414214 1.732051 2.000000 2.236068 2.449490 2.645751
##  [8] 2.828427 3.000000 3.162278
```

```r
map(x, sqrt)
```

```
## [[1]]
## [1] 1
## 
## [[2]]
## [1] 1.414214
## 
## [[3]]
## [1] 1.732051
## 
## [[4]]
## [1] 2
## 
## [[5]]
## [1] 2.236068
## 
## [[6]]
## [1] 2.44949
## 
## [[7]]
## [1] 2.645751
## 
## [[8]]
## [1] 2.828427
## 
## [[9]]
## [1] 3
## 
## [[10]]
## [1] 3.162278
```

Toy example 2 (functions on-the-fly): without using vectorization, square each component of `x`:


```r
map(x, function(x) x^2)
```

```
## [[1]]
## [1] 1
## 
## [[2]]
## [1] 4
## 
## [[3]]
## [1] 9
## 
## [[4]]
## [1] 16
## 
## [[5]]
## [1] 25
## 
## [[6]]
## [1] 36
## 
## [[7]]
## [1] 49
## 
## [[8]]
## [1] 64
## 
## [[9]]
## [1] 81
## 
## [[10]]
## [1] 100
```

Want a vector to be returned? Must specify the `typeof()` of the vector. Use `map_dbl()` to specify an output vector of type "double" for the above (check out the documentation `?map` for the acceptable vector types):


```r
map_dbl(x, sqrt)
```

```
##  [1] 1.000000 1.414214 1.732051 2.000000 2.236068 2.449490 2.645751
##  [8] 2.828427 3.000000 3.162278
```

Does your function have other arguments? You can specify them afterwards in the ellipses (`...`).


```r
map_chr(x, str_c, "potato.", sep="-")
```

```
##  [1] "1-potato."  "2-potato."  "3-potato."  "4-potato."  "5-potato." 
##  [6] "6-potato."  "7-potato."  "8-potato."  "9-potato."  "10-potato."
```

## Your Turn: `purrr` fundamentals

1. Let's retry the `wesanderson` example: use `purrr` to write code that extracts a vector of the first elements of each vector contained in `wesanderson`. Play around with the following, too:
    - Use `head` instead of writing your own function.
    - Try different `map` functions, even the "wrong" types.
    - Use the ` ``[`` ` function if you're feeling daring.


```r
map_chr(wesanderson, function(x) x[1])
```

```
##  GrandBudapest      Moonrise1         Royal1      Moonrise2     Cavalcanti 
##      "#F1BB7B"      "#F3DF6C"      "#899DA4"      "#798E87"      "#D8B70A" 
##         Royal2 GrandBudapest2      Moonrise3      Chevalier         Zissou 
##      "#9A8822"      "#E6A0C4"      "#85D4E3"      "#446455"      "#3B9AB2" 
##   FantasticFox     Darjeeling       Rushmore   BottleRocket    Darjeeling2 
##      "#DD8D29"      "#FF0000"      "#E1BD6D"      "#A42820"      "#ECCBAE"
```

```r
map_chr(wesanderson, head, 1)
```

```
##  GrandBudapest      Moonrise1         Royal1      Moonrise2     Cavalcanti 
##      "#F1BB7B"      "#F3DF6C"      "#899DA4"      "#798E87"      "#D8B70A" 
##         Royal2 GrandBudapest2      Moonrise3      Chevalier         Zissou 
##      "#9A8822"      "#E6A0C4"      "#85D4E3"      "#446455"      "#3B9AB2" 
##   FantasticFox     Darjeeling       Rushmore   BottleRocket    Darjeeling2 
##      "#DD8D29"      "#FF0000"      "#E1BD6D"      "#A42820"      "#ECCBAE"
```

```r
map_chr(wesanderson, `[`, 1)
```

```
##  GrandBudapest      Moonrise1         Royal1      Moonrise2     Cavalcanti 
##      "#F1BB7B"      "#F3DF6C"      "#899DA4"      "#798E87"      "#D8B70A" 
##         Royal2 GrandBudapest2      Moonrise3      Chevalier         Zissou 
##      "#9A8822"      "#E6A0C4"      "#85D4E3"      "#446455"      "#3B9AB2" 
##   FantasticFox     Darjeeling       Rushmore   BottleRocket    Darjeeling2 
##      "#DD8D29"      "#FF0000"      "#E1BD6D"      "#A42820"      "#ECCBAE"
```

2. Check that each character's list entry in `got_chars` has the same names as everyone else (that is, list component names, not character names). Here's one way to do it:
    1. Use the `names` function.
    2. Then, bind the names together in a single character.
    3. Then, apply the `table()` function.




## Shortcut functions

We can do the subsetting much easier with these shortcuts: just replace function with either:

- index you'd like to subset by, or
- name you'd like to subset by.


```r
map_chr(wesanderson, 1)  %>% unname()
```

```
##  [1] "#F1BB7B" "#F3DF6C" "#899DA4" "#798E87" "#D8B70A" "#9A8822" "#E6A0C4"
##  [8] "#85D4E3" "#446455" "#3B9AB2" "#DD8D29" "#FF0000" "#E1BD6D" "#A42820"
## [15] "#ECCBAE"
```


## Your turn: shortcut functions

1. For the `got_chars` data:

- What are the titles of each character?
- Is a vector output appropriate here?
- Use a pipe.

Note: each character's list entry has a component named `titles` as the 9th entry.


```r
map(got_chars, "titles")
```

```
## [[1]]
## [1] "Prince of Winterfell"                                
## [2] "Captain of Sea Bitch"                                
## [3] "Lord of the Iron Islands (by law of the green lands)"
## 
## [[2]]
## [1] "Acting Hand of the King (former)" "Master of Coin (former)"         
## 
## [[3]]
## [1] "Lord Captain of the Iron Fleet" "Master of the Iron Victory"    
## 
## [[4]]
## [1] ""
## 
## [[5]]
## [1] "Captain of the Guard at Sunspear"
## 
## [[6]]
## [1] ""
## 
## [[7]]
## [1] "Maester"
## 
## [[8]]
## [1] "Princess of Dorne"
## 
## [[9]]
## [1] "Queen of the Andals and the Rhoynar and the First Men, Lord of the Seven Kingdoms"
## [2] "Khaleesi of the Great Grass Sea"                                                  
## [3] "Breaker of Shackles/Chains"                                                       
## [4] "Queen of Meereen"                                                                 
## [5] "Princess of Dragonstone"                                                          
## 
## [[10]]
## [1] "Ser"                       "Lord of the Rainwood"     
## [3] "Admiral of the Narrow Sea" "Hand of the King"         
## 
## [[11]]
## [1] "Princess"
## 
## [[12]]
## [1] "Ser"
## 
## [[13]]
## [1] "Princess"                    "Captain of the Black Wind"  
## [3] "Conqueror of Deepwood Motte"
## 
## [[14]]
## [1] "Ser"               "Hand of the Queen"
## 
## [[15]]
## [1] ""
## 
## [[16]]
## [1] "Prince of Winterfell"
## 
## [[17]]
## [1] ""
## 
## [[18]]
## [1] "Lady of Winterfell"
## 
## [[19]]
## [1] "Light of the West"      "Queen Dowager"         
## [3] "Protector of the Realm" "Lady of Casterly Rock" 
## [5] "Queen Regent"          
## 
## [[20]]
## [1] "Lord of Winterfell"     "Warden of the North"   
## [3] "Hand of the King"       "Protector of the Realm"
## [5] "Regent"                
## 
## [[21]]
## [1] "Ser"                              "Lord Commander of the Kingsguard"
## [3] "Warden of the East (formerly)"   
## 
## [[22]]
## [1] "Lord of Griffin's Roost" "Hand of the King"       
## [3] "Hand of the True King"  
## 
## [[23]]
## [1] "Lord Commander of the Night's Watch"
## 
## [[24]]
## [1] "Priest of the Drowned God"             
## [2] "Captain of the Golden Storm (formerly)"
## 
## [[25]]
## [1] "Ser"                    "Master of laws"        
## [3] "Lord Regent"            "Protector of the Realm"
## 
## [[26]]
## [1] ""
## 
## [[27]]
## [1] ""
## 
## [[28]]
## [1] "Prince"
## 
## [[29]]
## [1] ""
## 
## [[30]]
## [1] "Princess"
```

```r
got_chars %>%
  map("titles")
```

```
## [[1]]
## [1] "Prince of Winterfell"                                
## [2] "Captain of Sea Bitch"                                
## [3] "Lord of the Iron Islands (by law of the green lands)"
## 
## [[2]]
## [1] "Acting Hand of the King (former)" "Master of Coin (former)"         
## 
## [[3]]
## [1] "Lord Captain of the Iron Fleet" "Master of the Iron Victory"    
## 
## [[4]]
## [1] ""
## 
## [[5]]
## [1] "Captain of the Guard at Sunspear"
## 
## [[6]]
## [1] ""
## 
## [[7]]
## [1] "Maester"
## 
## [[8]]
## [1] "Princess of Dorne"
## 
## [[9]]
## [1] "Queen of the Andals and the Rhoynar and the First Men, Lord of the Seven Kingdoms"
## [2] "Khaleesi of the Great Grass Sea"                                                  
## [3] "Breaker of Shackles/Chains"                                                       
## [4] "Queen of Meereen"                                                                 
## [5] "Princess of Dragonstone"                                                          
## 
## [[10]]
## [1] "Ser"                       "Lord of the Rainwood"     
## [3] "Admiral of the Narrow Sea" "Hand of the King"         
## 
## [[11]]
## [1] "Princess"
## 
## [[12]]
## [1] "Ser"
## 
## [[13]]
## [1] "Princess"                    "Captain of the Black Wind"  
## [3] "Conqueror of Deepwood Motte"
## 
## [[14]]
## [1] "Ser"               "Hand of the Queen"
## 
## [[15]]
## [1] ""
## 
## [[16]]
## [1] "Prince of Winterfell"
## 
## [[17]]
## [1] ""
## 
## [[18]]
## [1] "Lady of Winterfell"
## 
## [[19]]
## [1] "Light of the West"      "Queen Dowager"         
## [3] "Protector of the Realm" "Lady of Casterly Rock" 
## [5] "Queen Regent"          
## 
## [[20]]
## [1] "Lord of Winterfell"     "Warden of the North"   
## [3] "Hand of the King"       "Protector of the Realm"
## [5] "Regent"                
## 
## [[21]]
## [1] "Ser"                              "Lord Commander of the Kingsguard"
## [3] "Warden of the East (formerly)"   
## 
## [[22]]
## [1] "Lord of Griffin's Roost" "Hand of the King"       
## [3] "Hand of the True King"  
## 
## [[23]]
## [1] "Lord Commander of the Night's Watch"
## 
## [[24]]
## [1] "Priest of the Drowned God"             
## [2] "Captain of the Golden Storm (formerly)"
## 
## [[25]]
## [1] "Ser"                    "Master of laws"        
## [3] "Lord Regent"            "Protector of the Realm"
## 
## [[26]]
## [1] ""
## 
## [[27]]
## [1] ""
## 
## [[28]]
## [1] "Prince"
## 
## [[29]]
## [1] ""
## 
## [[30]]
## [1] "Princess"
```

2. For the `got_chars` data:

- Extract a list of the "name" and "born" data for each person.
    - Use the function ` ``[`` ` or `extract()` (from the `magrittr` package, does the same thing) function to do the subsetting
- What happens when we switch to `map_dfr` instead of `map`? How about `map_dfc`?


```r
desired_info <- c("name", "born")
map(got_chars, `[`, desired_info) %>% head
```

```
## [[1]]
## [[1]]$name
## [1] "Theon Greyjoy"
## 
## [[1]]$born
## [1] "In 278 AC or 279 AC, at Pyke"
## 
## 
## [[2]]
## [[2]]$name
## [1] "Tyrion Lannister"
## 
## [[2]]$born
## [1] "In 273 AC, at Casterly Rock"
## 
## 
## [[3]]
## [[3]]$name
## [1] "Victarion Greyjoy"
## 
## [[3]]$born
## [1] "In 268 AC or before, at Pyke"
## 
## 
## [[4]]
## [[4]]$name
## [1] "Will"
## 
## [[4]]$born
## [1] ""
## 
## 
## [[5]]
## [[5]]$name
## [1] "Areo Hotah"
## 
## [[5]]$born
## [1] "In 257 AC or before, at Norvos"
## 
## 
## [[6]]
## [[6]]$name
## [1] "Chett"
## 
## [[6]]$born
## [1] "At Hag's Mire"
```

```r
map_dfr(got_chars, `[`, desired_info)
```

```
## # A tibble: 30 x 2
##    name               born                                  
##    <chr>              <chr>                                 
##  1 Theon Greyjoy      In 278 AC or 279 AC, at Pyke          
##  2 Tyrion Lannister   In 273 AC, at Casterly Rock           
##  3 Victarion Greyjoy  In 268 AC or before, at Pyke          
##  4 Will               ""                                    
##  5 Areo Hotah         In 257 AC or before, at Norvos        
##  6 Chett              At Hag's Mire                         
##  7 Cressen            In 219 AC or 220 AC                   
##  8 Arianne Martell    In 276 AC, at Sunspear                
##  9 Daenerys Targaryen In 284 AC, at Dragonstone             
## 10 Davos Seaworth     In 260 AC or before, at King's Landing
## # ... with 20 more rows
```

Note: as Jenny says, it's always safer (from a programming perspective) to work with output that's more predictable. The following would be safer, and is still readable:


```r
got_chars %>% {
    tibble(
        name = map_chr(., "name"),
        born = map_chr(., "born")
    )
}
```

```
## # A tibble: 30 x 2
##    name               born                                  
##    <chr>              <chr>                                 
##  1 Theon Greyjoy      In 278 AC or 279 AC, at Pyke          
##  2 Tyrion Lannister   In 273 AC, at Casterly Rock           
##  3 Victarion Greyjoy  In 268 AC or before, at Pyke          
##  4 Will               ""                                    
##  5 Areo Hotah         In 257 AC or before, at Norvos        
##  6 Chett              At Hag's Mire                         
##  7 Cressen            In 219 AC or 220 AC                   
##  8 Arianne Martell    In 276 AC, at Sunspear                
##  9 Daenerys Targaryen In 284 AC, at Dragonstone             
## 10 Davos Seaworth     In 260 AC or before, at King's Landing
## # ... with 20 more rows
```

Note the curly braces "tricks" the object prior to the pipe from entering as the first argument to `tibble`, because ` ``{`` ` only returns the last line evaluated. In this case there are two: the above code is equivalent to


```r
got_chars %>% {
    .
    tibble(
        name = map_chr(., "name"),
        born = map_chr(., "born")
    )
}
```

```
## # A tibble: 30 x 2
##    name               born                                  
##    <chr>              <chr>                                 
##  1 Theon Greyjoy      In 278 AC or 279 AC, at Pyke          
##  2 Tyrion Lannister   In 273 AC, at Casterly Rock           
##  3 Victarion Greyjoy  In 268 AC or before, at Pyke          
##  4 Will               ""                                    
##  5 Areo Hotah         In 257 AC or before, at Norvos        
##  6 Chett              At Hag's Mire                         
##  7 Cressen            In 219 AC or 220 AC                   
##  8 Arianne Martell    In 276 AC, at Sunspear                
##  9 Daenerys Targaryen In 284 AC, at Dragonstone             
## 10 Davos Seaworth     In 260 AC or before, at King's Landing
## # ... with 20 more rows
```

