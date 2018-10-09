---
title: "cm011 Exercises: R as a programming language"
output: html_document
---

# Part I

## Types and Modes and Classes, Oh My!

R objects have a _type_, a _mode_, and a _class_. This can be confusing:


```r
a <- 3
print(typeof(a))
```

```
## [1] "double"
```

```r
print(mode(a))
```

```
## [1] "numeric"
```

```r
print(class(a))
```

```
## [1] "numeric"
```



```r
print(typeof(iris))
```

```
## [1] "list"
```

```r
print(mode(iris))
```

```
## [1] "list"
```

```r
print(class(iris))
```

```
## [1] "data.frame"
```



```r
print(typeof(sum))
```

```
## [1] "builtin"
```

```r
print(mode(sum))
```

```
## [1] "function"
```

```r
print(class(sum))
```

```
## [1] "function"
```

Usually, there's no need to fuss about these differences: just use the `is.*()` family of functions. Give it a try:


```r
is.numeric(a)
```

```
## [1] TRUE
```

```r
# [1] TRUE
is.double(a)
```

```
## [1] TRUE
```

```r
# [1] TRUE

is.data.frame(iris)
```

```
## [1] TRUE
```

```r
# [1] TRUE
is.list(iris)
```

```
## [1] TRUE
```

```r
# [1] TRUE
```

We can also coerce objects to take on a different form, typically using the `as.*()` family of functions. We can't always coerce! You'll get a sense of this over time, but try:

- Coercing a number to a character.
- Coercing a character to a number.
- Coercing a number to a data.frame. `letters` to a data.frame.


```r
as.character(100)
```

```
## [1] "100"
```

```r
as.numeric("100")
```

```
## [1] 100
```

```r
as.data.frame(letters)
```

```
##    letters
## 1        a
## 2        b
## 3        c
## 4        d
## 5        e
## 6        f
## 7        g
## 8        h
## 9        i
## 10       j
## 11       k
## 12       l
## 13       m
## 14       n
## 15       o
## 16       p
## 17       q
## 18       r
## 19       s
## 20       t
## 21       u
## 22       v
## 23       w
## 24       x
## 25       y
## 26       z
```

There is also a slight difference between coercion and conversion, but this is usually not important.

## Vectors

Vectors store multiple entries of a data type. You'll discover that they show up just about everywhere in R, so they're fundamental and extremely important.

### Vector Construction and Basic Subsetting

We've seen vectors as columns of data frames:


```r
mtcars$hp
```

```
##  [1] 110 110  93 110 175 105 245  62  95 123 123 180 180 180 205 215 230
## [18]  66  52  65  97 150 150 245 175  66  91 113 264 175 335 109
```

Use the `c()` function to make a vector consisting of the course code (`"STAT"` and `545`). Notice the coercion. Vectors must be homogeneous.


```r
course <- c("STAT", 545)
```


Subset the first entry. Remove the first entry. Note the base-1 system.


```r
course[1]
```

```
## [1] "STAT"
```

```r
course[-1]
```

```
## [1] "545"
```

Use `<-` to change the second entry to "545A". Using the same approach, add a third entry, "S01".


```r
course[2:3] <- c("545A", "S01")
```

Subset the first and third entry. Order matters! Subset the third and first entry.


```r
course[c(1, 3)]
```

```
## [1] "STAT" "S01"
```

```r
course[c(3, 1)]
```

```
## [1] "S01"  "STAT"
```

```r
course[-2]
```

```
## [1] "STAT" "S01"
```

```r
rev(course[-2])
```

```
## [1] "S01"  "STAT"
```

Explore integer sequences, especially negatives and directions. Especially `1:0` that might show up in loops!


```r
3:10
```

```
## [1]  3  4  5  6  7  8  9 10
```

```r
10:-5
```

```
##  [1] 10  9  8  7  6  5  4  3  2  1  0 -1 -2 -3 -4 -5
```

```r
1:0
```

```
## [1] 1 0
```

```r
#Vector of length zero
seq_len(0)
```

```
## integer(0)
```

```r
seq_len(10)
```

```
##  [1]  1  2  3  4  5  6  7  8  9 10
```

Singletons are also vectors. Check using `is.vector`.


```r
is.vector(3)
```

```
## [1] TRUE
```

```r
a[1][1][1]
```

```
## [1] 3
```


### Vectorization and Recycling

A key aspect of R is its vectorization. Let's work with the vector following vector:


```r
(a <- 7:-2)
```

```
##  [1]  7  6  5  4  3  2  1  0 -1 -2
```

```r
(n <- length(a))
```

```
## [1] 10
```

Square each component:


```r
a^2
```

```
##  [1] 49 36 25 16  9  4  1  0  1  4
```

Multiply each component by 1 through its length:


```r
a * 1:10
```

```
##  [1]   7  12  15  16  15  12   7   0  -9 -20
```

It's important to know that R will silently recycle! Unless the length of one vector is not divisible by the other. Let's see:


```r
a * 1:3 # Print warning
```

```
## Warning in a * 1:3: longer object length is not a multiple of shorter
## object length
```

```
##  [1]  7 12 15  4  6  6  1  0 -3 -2
```

```r
a * 1:5
```

```
##  [1]   7  12  15  16  15   2   2   0  -4 -10
```


This is true of comparison operators, too. Make a vector of logicals using a comparison operator.


```r
a < 1:5
```

```
##  [1] FALSE FALSE FALSE FALSE  TRUE FALSE  TRUE  TRUE  TRUE  TRUE
```


Now try a boolean operator. Note that && and || are NOT vectorized!


```r
a > 0 & a < 5
```

```
##  [1] FALSE FALSE FALSE  TRUE  TRUE  TRUE  TRUE FALSE FALSE FALSE
```

```r
# Vectorized

a > 0 && a < 5
```

```
## [1] FALSE
```

```r
# Not vectorized, useful for if statements
# only compares first entry of either side
```


Recycling works with assignment, too. Replace the entire vector a with 1:2 repeated:


```r
a[1:n] <- 1:2
a
```

```
##  [1] 1 2 1 2 1 2 1 2 1 2
```


### Special Subsetting

We can subset vectors by names and logicals, too.

Recall the course vector:


```r
course <- c("STAT", "545A", "S01")
```

Let's give the components some names ("subject", "code", and "section") using three methods:

1. Using the setNames function.
- Notice that the vector does not change!!


```r
setNames(course, c("subject", "name", "section"))
```

```
## subject    name section 
##  "STAT"  "545A"   "S01"
```

2. Using the names function with `<-`. Also, just explore the names function.


```r
names(course) <- c("subject", "name", "section")
course
```

```
## subject    name section 
##  "STAT"  "545A"   "S01"
```

```r
names(course) #for just names
```

```
## [1] "subject" "name"    "section"
```

3. Re-constructing the vector, specifying names within `c()`.


```r
course <- c(subject = "STAT", name = "545", section = "S01")
```


Subset the entry labelled "section" and "subject".


```r
course[c("subject", "section")]
```

```
## subject section 
##  "STAT"   "S01"
```

Amazingly, we can also subset by a vector of logicals (which will be recycled!). Let's work with our integer sequence vector again:


```r
(a <- 7:-2)
```

```
##  [1]  7  6  5  4  3  2  1  0 -1 -2
```

```r
(n <- length(a))
```

```
## [1] 10
```

```r
a[a > 0]
```

```
## [1] 7 6 5 4 3 2 1
```

## Lists

Unlike vectors, which are atomic/homogeneous, a list in R is heterogeneous.

Try storing the course code (`"STAT"` and `545`) again, but this time in a list. Use the `list()` function.


```r
course <- list("STAT", 545)
```


Lists can hold pretty much anything, and can also be named. Let's use the following list:


```r
(my_list <- list(year=2018, instructor=c("Vincenzo", "Coia"), fav_fun=typeof))
```

```
## $year
## [1] 2018
## 
## $instructor
## [1] "Vincenzo" "Coia"    
## 
## $fav_fun
## function (x) 
## .Internal(typeof(x))
## <bytecode: 0x5628b708d0b0>
## <environment: namespace:base>
```


Subsetting a list works similarly to vectors. Try subsetting the first element of `my_list`; try subsettig the first _component_ of the list. Notice the difference!


```r
my_list[1]
```

```
## $year
## [1] 2018
```

```r
my_list[[1]]
```

```
## [1] 2018
```

```r
my_list[2]
```

```
## $instructor
## [1] "Vincenzo" "Coia"
```

```r
my_list[[2]]
```

```
## [1] "Vincenzo" "Coia"
```

```r
#Double square brackets strips the list structure and gives content
```

Try also subsetting by name:


```r
my_list["year"]
```

```
## $year
## [1] 2018
```

```r
my_list[["year"]]
```

```
## [1] 2018
```

```r
my_list$year
```

```
## [1] 2018
```

Smells a little like `data.frame`s. It turns out a `data.frame` is a special type of list:

A data.frame is a list of vectors of equal length. Each vector is a column, entries at a particular index across vectors comprise each row


```r
(small_df <- tibble::tibble(x=1:5, y=letters[1:5]))
```

```
## # A tibble: 5 x 2
##       x y    
##   <int> <chr>
## 1     1 a    
## 2     2 b    
## 3     3 c    
## 4     4 d    
## 5     5 e
```


```r
is.list(small_df)
```

```
## [1] TRUE
```


```r
as.list(small_df)
```

```
## $x
## [1] 1 2 3 4 5
## 
## $y
## [1] "a" "b" "c" "d" "e"
```

Note that there's a difference between a list of one object, and that object itself! This is different from vectors.


```r
identical(list(4), 4)
```

```
## [1] FALSE
```

```r
identical(list(4)[[1]], 4)
```

```
## [1] TRUE
```

```r
identical(c(4), 4)
```

```
## [1] TRUE
```

What about matrices?


```r
diag(5)
```

```
##      [,1] [,2] [,3] [,4] [,5]
## [1,]    1    0    0    0    0
## [2,]    0    1    0    0    0
## [3,]    0    0    1    0    0
## [4,]    0    0    0    1    0
## [5,]    0    0    0    0    1
```
All cells must be of the same type (only numerics?) which makes it less useful for storing data

# Part II

## Global Environment

When you assign variables in R, the variable name and contents are stored in an R environment called a global environment.

See what's in the Global Environment by:

- Executing `ls()`.
- Looking in RStudio, in the "Environments" pane.




Making an assignment "binds" an object to a name within an environment. For example, writing `a <- 5` assigns the object `5` to the name `a` in the global environment.

The act of "searching for the right object to return" is called scoping.

By the way: the global environment is an object, too! It's the output of `globalenv()`, and is also stored in the variable `.GlobalEnv`:


```r
globalenv()
```

```
## <environment: R_GlobalEnv>
```

```r
.GlobalEnv
```

```
## <environment: R_GlobalEnv>
```

## The Search Path

How does R know what `iris` is, yet `iris` does not appear in the global environment? What about functions like `length`, `sum`, and `print` (which are all objects, too)?

Let's explore.

1. Each package has its own environment.
    - Install and load the `pryr` package, and use `ls()` to list its bindings (its name is "package:pryr").



2. There's a difference between an _environment_ and its _name_. Get the environment with name "package:pryr" using the `as.environment()` function.




3. Each environment has a parent. Use `parent.env()` to find the parent of the global environment.




4. There are packages that come pre-loaded with R, and they're loaded in a sequence called the search path. Use `search()` to identify that path; then see it in RStudio.



First scoping rule: R looks to the parent environment if it can't find an object where it is.

5. Use `pryr::where()` to determine where the first binding to the name `iris` is located.




6. Override `iris` with, say, a numeric. Now `where()` is it? Can you extract the original?




7. Override `sum` with, say, a numeric. `where()` is `sum` now? Can you still use the original `sum()` function?



Special scoping rule for functions! R knows whether or not to look for a function.

8. Look at the source code of the `pryr:where()` function. It contains a line that creates a binding for "env". Why, then, is `env` nowhere to be found? Answer: execution environments.


```r
pryr::where
```

```
## Error in loadNamespace(name): there is no package called 'pryr'
```



