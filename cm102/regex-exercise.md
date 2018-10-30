---
title: "STAT 547 Class Meeting 02 Worksheet"
output: github_document
---


```r
suppressPackageStartupMessages(library(tidyverse))
library(gapminder)
library(testthat)
```

```
## 
## Attaching package: 'testthat'
```

```
## The following object is masked from 'package:dplyr':
## 
##     matches
```

```
## The following object is masked from 'package:purrr':
## 
##     is_null
```

```r
library(knitr)
```

## Resources

Today's lesson has been drawn from the following resources:

1. Mostly [stat545.com: character data](http://stat545.com/block028_character-data.html)
    - See the ["Resources" section](http://stat545.com/block028_character-data.html#resources) for a more comprehensive listing of resources based on the character problem you're facing.
2. [Older stat545 notes](http://stat545.com/block022_regular-expression.html)
3. [r4ds: strings](https://r4ds.had.co.nz/strings.html).
3. [`stringr` vignette](https://cran.r-project.org/web/packages/stringr/vignettes/stringr.html)

## Basic String Manipulation

__Goal__: Go over some basic functionality of `stringr`.

There's that famous sentence about the quick brown fox that contains all letters of the alphabet, although I don't quite remember the sentence. Demo: Check to see if it's in the `sentences` data. Try:

`str_detect(string, pattern)`
`str_subset(string, pattern)`


```r
head(sentences)
```

```
## [1] "The birch canoe slid on the smooth planks." 
## [2] "Glue the sheet to the dark blue background."
## [3] "It's easy to tell the depth of a well."     
## [4] "These days a chicken leg is a rare dish."   
## [5] "Rice is often served in round bowls."       
## [6] "The juice of lemons makes fine punch."
```

```r
fox <- str_subset(sentences, pattern = "fox")
# returns the whole entry that has a match
fox
```

```
## [1] "The quick fox jumped on the sleeping cat."
```

Not quite the sentence I was thinking of. How many words does it contain? Use `str_split(string, pattern)`, noting its output (list).


```r
str_split(fox, " ")[[1]] %>% length
```

```
## [1] 8
```

```r
# output is list since it can be hierarchical. That's why we need to [[1]] before piping to length. For example

str_split(sentences, " ") %>% head
```

```
## [[1]]
## [1] "The"     "birch"   "canoe"   "slid"    "on"      "the"     "smooth" 
## [8] "planks."
## 
## [[2]]
## [1] "Glue"        "the"         "sheet"       "to"          "the"        
## [6] "dark"        "blue"        "background."
## 
## [[3]]
## [1] "It's"  "easy"  "to"    "tell"  "the"   "depth" "of"    "a"     "well."
## 
## [[4]]
## [1] "These"   "days"    "a"       "chicken" "leg"     "is"      "a"      
## [8] "rare"    "dish."  
## 
## [[5]]
## [1] "Rice"   "is"     "often"  "served" "in"     "round"  "bowls."
## 
## [[6]]
## [1] "The"    "juice"  "of"     "lemons" "makes"  "fine"   "punch."
```

Exercise: does this sentence contain all letters of the alphabet? Hints:

- Split by `""`.
- Consider putting all in lowercase with `str_to_lower()`.
- Use the base R `table()` function.


```r
fox %>%
  str_split("") %>%
  `[[`(1) %>% # This is the lower-level strip list structure function
  str_to_lower %>%
  table
```

```
## .
##   . a c d e f g h i j k l m n o p q s t u x 
## 7 1 1 2 1 5 1 1 2 2 1 1 1 1 2 2 2 1 1 3 2 1
```


Working in a data frame? `tidyr` has its own version of this. Here's an example from Resource 1, with the fruit data:


```r
tibble(fruit)
```

```
## # A tibble: 80 x 1
##    fruit       
##    <chr>       
##  1 apple       
##  2 apricot     
##  3 avocado     
##  4 banana      
##  5 bell pepper 
##  6 bilberry    
##  7 blackberry  
##  8 blackcurrant
##  9 blood orange
## 10 blueberry   
## # ... with 70 more rows
```

```r
tibble(fruit) %>%
  separate(fruit, into = c("pre", "post"), sep = " ")
```

```
## Warning: Expected 2 pieces. Missing pieces filled with `NA` in 69 rows [1,
## 2, 3, 4, 6, 7, 8, 10, 11, 12, 14, 15, 16, 18, 19, 20, 21, 22, 23, 24, ...].
```

```
## # A tibble: 80 x 2
##    pre          post  
##    <chr>        <chr> 
##  1 apple        <NA>  
##  2 apricot      <NA>  
##  3 avocado      <NA>  
##  4 banana       <NA>  
##  5 bell         pepper
##  6 bilberry     <NA>  
##  7 blackberry   <NA>  
##  8 blackcurrant <NA>  
##  9 blood        orange
## 10 blueberry    <NA>  
## # ... with 70 more rows
```

Demo: we can substitute, too. Replace the word "fox" with "giraffe" using `str_replace(string, pattern, replacement)`:


```r
fox %>%
    str_replace("fox", "giraffe")
```

```
## [1] "The quick giraffe jumped on the sleeping cat."
```

```r
# = str_replace(pattern = "fox", replacement = "giraffe")
```

Know the position you want to extract/replace? Try `str_sub()`.

`str_pad()` extends each string to a minimum length:


```r
fruit %>% head
```

```
## [1] "apple"       "apricot"     "avocado"     "banana"      "bell pepper"
## [6] "bilberry"
```

```r
fruit %>%
    str_pad(width=7, side="right", pad="$") %>%
    head()
```

```
## [1] "apple$$"     "apricot"     "avocado"     "banana$"     "bell pepper"
## [6] "bilberry"
```

`str_length()` (Not the same as `length()`!)


```r
str_length(fruit) # Length of each string entry in a character vector
```

```
##  [1]  5  7  7  6 11  8 10 12 12  9 11 10 12 10  9  6 12 10 10  7  9  8  7
## [24]  6  4 11  6  8 10  6  3 10 10  5 10  5  8 11  9  6  6 10  7  5  4  6
## [47]  6  9  5  8  9  3  5  6  6  6 12  5  4  9  8  9  4 11  6 17  6  6  8
## [70]  9 10 10 11  7 10 10  9  9 10 10
```

```r
length(fruit)     # Length of vector
```

```
## [1] 80
```


`str_c()` for concatenating strings. Check the docs for an excellent explanation using a matrix.


```r
str_c(words[1:4], words[5:8], sep=" & ")
```

```
## [1] "a & accept"        "able & account"    "about & achieve"  
## [4] "absolute & across"
```

```r
str_c(words[3:4], words[5:8], sep=" & ")
```

```
## [1] "about & accept"     "absolute & account" "about & achieve"   
## [4] "absolute & across"
```

```r
str_c(words[3:4], words[5:8], sep=" & ", collapse=", ")
```

```
## [1] "about & accept, absolute & account, about & achieve, absolute & across"
```

There's a (more limited) `tidyr` version. Straight from Resource 1:


```r
fruit_df <- tibble(
  fruit1 = fruit[1:4],
  fruit2 = fruit[5:8]
)
fruit_df %>%
  unite("flavor_combo", fruit1, fruit2, sep = " & ")
```

```
## # A tibble: 4 x 1
##   flavor_combo         
##   <chr>                
## 1 apple & bell pepper  
## 2 apricot & bilberry   
## 3 avocado & blackberry 
## 4 banana & blackcurrant
```


## Exercise: Populate your Participation Repo

So, you don't want to manually make 12 folders for your participation repo. I hear you. Let's do that by making a character vector with entries `"cm101"`, `"cm102"`, ..., `"cm112"`.

(If you've already done this, it's still a useful exercise!)

### Make Folders

Let's make those folders!

1. Make a character vector with entries `"01"`, `"02"`, ..., `12` with `str_pad()`.


```r
(num <- str_pad(1:12, width=2, side="left", pad="0"))
```

```
##  [1] "01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12"
```

2. Use `str_c()` to combine `"cm1"` with the numbers:
    - If your system uses "\" instead of "/", you might need two backslashes.


```r
(folders <- str_c("../cm1",num))
```

```
##  [1] "../cm101" "../cm102" "../cm103" "../cm104" "../cm105" "../cm106"
##  [7] "../cm107" "../cm108" "../cm109" "../cm110" "../cm111" "../cm112"
```

3. Use `testthat` to check that each entry of `folders` has 5 characters. You might find the base R `all()` function useful.


```r
test_that("folder names are length 5. (8 with ../)", {
    expect_equal(str_length(folders), rep(8,12))
})
# Banzai!
```

4. BONUS: If applicable, make the folders using `dir.create()`.
    - Note: `dir.create()` requires the full path to be specified. You might find the `here::here()` function useful.
    - This code might work (depending on your directory): `for (folder in folders) dir.create(here::here(folder))`
    - We'll learn how to use `purrr` instead of loops next week.

```r
# sapply(X = folders,FUN = dir.create)
```


### Make README's

Now, let's seed the folders with README's.

1. Add `/README.md` to the end of the folder names stored in `folders`:


```r
files <- str_c(folders, "/README.md")
```

2. Make a vector of contents to put in each README. Put a title and body.
    - Hint: Use `\n` to indicate a new line! This works in graphs, too.


```r
contents <- str_c("# Participation\n\n Participation for class meeting ", 1:12)
```

3. BONUS: Write the README's to file using base R's `write(x, file)`:
    - `for (i in 1:length(files)) write(contents[i], files[i])`
    - There's a better alternative to a loop using `purrr`. Next week's topic!
    - This code might not work, depending on your workind directory and system.

## Regular Expressions (aka regex)

Great resource is [r4ds](https://r4ds.had.co.nz/strings.html#matching-patterns-with-regular-expressions)!

Premable:

- Useful for identifying _patterns_, not exact character specifications.
- Hard to read and write!
- We'll focus on finding _matches_ (the hardest part). You can also use regex to manipulate strings -- but we'll delegate that to [r4ds: strings: tools](https://r4ds.had.co.nz/strings.html#tools).

Staying true to Resource 1, let's work with the gapminder countries:


```r
library(gapminder)
countries <- levels(gapminder$country)
```

### The "any character"

Find all countries in the gapminder data set with the following pattern: "i", followed by any single character, followed by "a":


```r
str_subset(countries, pattern = "[iI].a")
```

```
##  [1] "Argentina"                "Bosnia and Herzegovina"  
##  [3] "Burkina Faso"             "Central African Republic"
##  [5] "China"                    "Costa Rica"              
##  [7] "Dominican Republic"       "Hong Kong, China"        
##  [9] "Iran"                     "Iraq"                    
## [11] "Italy"                    "Jamaica"                 
## [13] "Mauritania"               "Nicaragua"               
## [15] "South Africa"             "Swaziland"               
## [17] "Taiwan"                   "Thailand"                
## [19] "Trinidad and Tobago"
```

Here, `.` stands for "any single character".

But, where's Italy? Case-sensitive!

Let's use `str_subset()` to see the matches:


```r
str_subset(countries, pattern = "i.a")
```

```
##  [1] "Argentina"                "Bosnia and Herzegovina"  
##  [3] "Burkina Faso"             "Central African Republic"
##  [5] "China"                    "Costa Rica"              
##  [7] "Dominican Republic"       "Hong Kong, China"        
##  [9] "Jamaica"                  "Mauritania"              
## [11] "Nicaragua"                "South Africa"            
## [13] "Swaziland"                "Taiwan"                  
## [15] "Thailand"                 "Trinidad and Tobago"
```

```r
str_subset(countries, pattern = "i.a", match=TRUE)
```

```
## Error in str_subset(countries, pattern = "i.a", match = TRUE): unused argument (match = TRUE)
```

Exercise: Canada isn't the only country with three interspersed "a"'s. Find the others. Try both `str_subset()` and `str_subset()`.


```r
str_subset(countries, "a.a.a", match = T)
```

```
## Error in str_subset(countries, "a.a.a", match = T): unused argument (match = T)
```

```r
str_subset(countries, "a.a.a")
```

```
## [1] "Canada"     "Madagascar" "Panama"
```


Let's define a handy function:


```r
str_subset <- function(countries, pattern) {
    str_subset(countries, pattern, match=TRUE)
}

str_subset(countries, pattern = "i.a")
```

```
## Error in str_subset(countries, pattern, match = TRUE): unused argument (match = TRUE)
```


### The escape

What if I wanted to literally search for countries with a period in the name? Escape with `\`, although R requires a double escape.


```r
str_subset(countries, pattern = "\\.")
```

```
## Error in str_subset(countries, pattern, match = TRUE): unused argument (match = TRUE)
```

```r
str_subset
```

```
## function(countries, pattern) {
##     str_subset(countries, pattern, match=TRUE)
## }
## <bytecode: 0x55d42af059f8>
```

Why does R require a double escape? It does one level of escaping before "executing" the regex.

- See `?Quotes`
- Try searching for "s\. " (without quotes) in this document (don't forget to select "Regex")

### Character Classes

- `[letters]` matches a single character that's either l, e, t, ..., or s.
- `[^letters]`: anything _but_ these letters.

See more at: https://r4ds.had.co.nz/strings.html#character-classes-and-alternatives

Note that not all special characters "work" within `[]`, but some do, and do not always carry the same meaning (like `^`)! From said resource, they are:

>  `$` `.` `|` `?` `*` `+` `(` `)` `[` `{`. Unfortunately, a few characters have special meaning even inside a character class and must be handled with backslash escapes: `]` `\` `^` and `-`.

Exercise: Find all countries with three non-vowels next to each other.


```r
str_subset(countries, pattern = "[^AEIOUaeiou ][^AEIOUaeiou ][^ AEIOUaeiou]")
```

```
## Error in str_subset(countries, pattern, match = TRUE): unused argument (match = TRUE)
```


### Or

- Use `|` to denote "or".
- "And" is implied otherwise, and has precedence.
- Use parentheses to indicate precedence.

Beer or bear?


```r
c("bear", "beer", "bar","betr") %>%
    str_subset(pattern = "be(e|a)r")
```

```
## Error in str_subset(countries, pattern, match = TRUE): unused argument (match = TRUE)
```


### Quantifiers/Repetition

The handy ones are:

- `*` for 0 or more
- `+` for 1 or more
- `?` for 0 or 1

See list at https://r4ds.had.co.nz/strings.html#repetition

Find all countries that have any number of o's (but at least 1) following r:


```r
str_subset(countries, "ro+")
```

```
## Error in str_subset(countries, pattern, match = TRUE): unused argument (match = TRUE)
```


Find all countries that have exactly two e's next two each other:


```r
str_subset(countries, "e{2}")
```

```
## Error in str_subset(countries, pattern, match = TRUE): unused argument (match = TRUE)
```


Exercise: Find all countries that have either "a" or "e", twice in a row (with a changeover allowed, such as "ae" or "ea"):


```r
str_subset(countries, pattern="[ea][ea]")
```

```
## Error in str_subset(countries, pattern, match = TRUE): unused argument (match = TRUE)
```

```r
str_subset(countries, pattern="(e|a)(e|a)")
```

```
## Error in str_subset(countries, pattern, match = TRUE): unused argument (match = TRUE)
```


### Position indicators

- `^` corresponds to the __beginning__ of the line.
- `$` corresponds to the __end__ of the line.

Countries that end in "land":


```r
str_subset(countries, pattern = "land$")
```

```
## Error in str_subset(countries, pattern, match = TRUE): unused argument (match = TRUE)
```

```r
str_subset(countries, pattern = "$")
```

```
## Error in str_subset(countries, pattern, match = TRUE): unused argument (match = TRUE)
```

Countries that start with "Ca":


```r
str_subset(countries, pattern = "^Ca")
```

```
## Error in str_subset(countries, pattern, match = TRUE): unused argument (match = TRUE)
```

Countries without a vowel? The word should start with a non-vowel, continue as a non-vowel, and end:


```r
str_subset(countries, "^[^aeiouAEIOU]*$")
```

```
## Error in str_subset(countries, pattern, match = TRUE): unused argument (match = TRUE)
```

### Groups

We can refer to parentheses groups:


```r
str_subset(c("abad", "abbd"), pattern="(a)(b)\\1")
```

```
## Error in str_subset(countries, pattern, match = TRUE): unused argument (match = TRUE)
```

```r
str_subset(c("abad", "abbd"), pattern="(a)(b)\\2")
```

```
## Error in str_subset(countries, pattern, match = TRUE): unused argument (match = TRUE)
```

Note that the parentheses are first resolved, THEN referred to. NOT re-executed.


```r
str_subset(c("bananas", "bananans", "banana batman"), "(.)(.)\\1\\2.*\\1\\2")
```

```
## Error in str_subset(countries, pattern, match = TRUE): unused argument (match = TRUE)
```

We can refer to them later in the search, too:


```r
str_subset(c("bananas", "Who can? Bananas can."), "(.)(.)\\1\\2.*\\1\\2")
```

```
## Error in str_subset(countries, pattern, match = TRUE): unused argument (match = TRUE)
```


## Final Exercises

Convert `words` to pig latin, which involves:

1. Make the first letter the last letter #
    - Get the first letter with `str_sub(string, start, end)`.
2. Remove the first letter from `words`.
    - Hint: leave the `end` argument blank.
3. Add "ay" to the end of the word.
    - Use `str_c()`.


```r
YOUR_CODE_HERE
```

```
## Error in eval(expr, envir, enclos): object 'YOUR_CODE_HERE' not found
```

Find all countries that end in "y"


```r
str_subset(countries, "YOUR_REGEX_HERE")
```

```
## Error in str_subset(countries, pattern, match = TRUE): unused argument (match = TRUE)
```

Find all countries that have the same letter repeated twice (like "Greece", which has "ee").


```r
str_subset(countries, "YOUR_REGEX_HERE")
```

```
## Error in str_subset(countries, pattern, match = TRUE): unused argument (match = TRUE)
```

Find all countries that end in two vowels.


```r
str_subset(countries, "YOUR_REGEX_HERE")
```

```
## Error in str_subset(countries, pattern, match = TRUE): unused argument (match = TRUE)
```

Find all countries that start with two non-vowels. How is this different from finding all countries that end in _at least_ two non-vowels? Hint: Syria.


```r
countries %>%
    str_to_lower() %>%
    str_subset("YOUR_REGEX_HERE")
```

```
## Error in str_subset(countries, pattern, match = TRUE): unused argument (match = TRUE)
```

Find all countries that have either "oo" or "cc" in them.


```r
str_subset(countries, "YOUR_REGEX_HERE")
```

```
## Error in str_subset(countries, pattern, match = TRUE): unused argument (match = TRUE)
```
