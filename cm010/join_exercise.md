---
title: "cm010 Exercises"
output: github_document
---


```r
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(nycflights13))
```

## Types of mutating join

### Let's join tibbles using four mutating functions:  `left_join`, `right_join`, `inner_join` and `full_join`.

### create two tibbles named `a` and `b`


```r
(a <- tibble(x1 = LETTERS[1:3], x2 = 1:3))
```

```
## # A tibble: 3 x 2
##   x1       x2
##   <chr> <int>
## 1 A         1
## 2 B         2
## 3 C         3
```

```r
(b <- tibble(x1 = LETTERS[c(1,2,4)], x3 = c("T", "F", "T")))
```

```
## # A tibble: 3 x 2
##   x1    x3   
##   <chr> <chr>
## 1 A     T    
## 2 B     F    
## 3 D     T
```

### left_join: Join matching rows from `b` to `a` by matching "x1" variable


```r
left_join(a, b, by = "x1")
```

```
## # A tibble: 3 x 3
##   x1       x2 x3   
##   <chr> <int> <chr>
## 1 A         1 T    
## 2 B         2 F    
## 3 C         3 <NA>
```

### right_join: Join matching rows from `a` to `b` by matching "x1" variable.


```r
right_join(a, b)
```

```
## Joining, by = "x1"
```

```
## # A tibble: 3 x 3
##   x1       x2 x3   
##   <chr> <int> <chr>
## 1 A         1 T    
## 2 B         2 F    
## 3 D        NA T
```

### inner_join: Join data. Retain only rows in both sets `a` to `b` by matching "x1" variable.


```r
inner_join(a, b)
```

```
## Joining, by = "x1"
```

```
## # A tibble: 2 x 3
##   x1       x2 x3   
##   <chr> <int> <chr>
## 1 A         1 T    
## 2 B         2 F
```

### full_join: Join data. Retain all values, all rows of `a` to `b` by matching "x1"


```r
full_join(a, b)
```

```
## Joining, by = "x1"
```

```
## # A tibble: 4 x 3
##   x1       x2 x3   
##   <chr> <int> <chr>
## 1 A         1 T    
## 2 B         2 F    
## 3 C         3 <NA> 
## 4 D        NA T
```

### what happen if we do not specify `by` option?

Oops, but it's fine. by is only needed when the col names aren't the same (or you have multiple similar col names you don't want to join by)

### what happen if we join two different variables (e.g., "x1" to "x3") from two tibbles `a` to `b`?


```r
full_join(a,b, by = c("x1" = "x3"))
```

```
## # A tibble: 6 x 3
##   x1       x2 x1.y 
##   <chr> <int> <chr>
## 1 A         1 <NA> 
## 2 B         2 <NA> 
## 3 C         3 <NA> 
## 4 T        NA A    
## 5 F        NA B    
## 6 T        NA D
```

### what happen if two columns of `a` and `c` datasets have the identical colnames?


```r
# make data frame c and use inner_join()
(c <- tibble(x1 = c(LETTERS[1:2],"x"), x2 = c(1,4,5)))
```

```
## # A tibble: 3 x 2
##   x1       x2
##   <chr> <dbl>
## 1 A         1
## 2 B         4
## 3 x         5
```

```r
full_join(a,c)
```

```
## Joining, by = c("x1", "x2")
```

```
## # A tibble: 5 x 2
##   x1       x2
##   <chr> <dbl>
## 1 A         1
## 2 B         2
## 3 C         3
## 4 B         4
## 5 x         5
```

## In class practice

`nycflights13` dataset has several tibbles e.g., `flights`, `airports`, `planes`, `weather`.

### 1. Explore `nycflights13` dataset


```r
#check the tibbles included in `nycflights13` package
class(flights)
```

```
## [1] "tbl_df"     "tbl"        "data.frame"
```

```r
colnames(flights)
```

```
##  [1] "year"           "month"          "day"            "dep_time"      
##  [5] "sched_dep_time" "dep_delay"      "arr_time"       "sched_arr_time"
##  [9] "arr_delay"      "carrier"        "flight"         "tailnum"       
## [13] "origin"         "dest"           "air_time"       "distance"      
## [17] "hour"           "minute"         "time_hour"
```

```r
colnames(airlines)
```

```
## [1] "carrier" "name"
```

```r
colnames(weather)
```

```
##  [1] "origin"     "year"       "month"      "day"        "hour"      
##  [6] "temp"       "dewp"       "humid"      "wind_dir"   "wind_speed"
## [11] "wind_gust"  "precip"     "pressure"   "visib"      "time_hour"
```

### 2. Drop unimportant variables so it's easier to understand the join results. Also take first 1000 rows to run it faster.


```r
flights2 <- flights[1:1000,] %>%
  select(year, tailnum, carrier, time_hour)
```

### 3. Add airline names to `flights2` from `airlines` dataset.


```r
# Which join function to use?
left_join(flights2, airlines)
```

```
## Joining, by = "carrier"
```

```
## # A tibble: 1,000 x 5
##     year tailnum carrier time_hour           name                    
##    <int> <chr>   <chr>   <dttm>              <chr>                   
##  1  2013 N14228  UA      2013-01-01 05:00:00 United Air Lines Inc.   
##  2  2013 N24211  UA      2013-01-01 05:00:00 United Air Lines Inc.   
##  3  2013 N619AA  AA      2013-01-01 05:00:00 American Airlines Inc.  
##  4  2013 N804JB  B6      2013-01-01 05:00:00 JetBlue Airways         
##  5  2013 N668DN  DL      2013-01-01 06:00:00 Delta Air Lines Inc.    
##  6  2013 N39463  UA      2013-01-01 05:00:00 United Air Lines Inc.   
##  7  2013 N516JB  B6      2013-01-01 06:00:00 JetBlue Airways         
##  8  2013 N829AS  EV      2013-01-01 06:00:00 ExpressJet Airlines Inc.
##  9  2013 N593JB  B6      2013-01-01 06:00:00 JetBlue Airways         
## 10  2013 N3ALAA  AA      2013-01-01 06:00:00 American Airlines Inc.  
## # ... with 990 more rows
```

### 4. Add `weather` information to the `flights2` dataset by matching "year" and "time_hour" variables.


```r
flights2 %>%
  left_join(weather, by = c("year", "time_hour"))
```

```
## # A tibble: 2,888 x 17
##     year tailnum carrier time_hour           origin month   day  hour  temp
##    <dbl> <chr>   <chr>   <dttm>              <chr>  <dbl> <int> <int> <dbl>
##  1  2013 N14228  UA      2013-01-01 05:00:00 EWR        1     1     5  39.0
##  2  2013 N14228  UA      2013-01-01 05:00:00 JFK        1     1     5  39.0
##  3  2013 N14228  UA      2013-01-01 05:00:00 LGA        1     1     5  39.9
##  4  2013 N24211  UA      2013-01-01 05:00:00 EWR        1     1     5  39.0
##  5  2013 N24211  UA      2013-01-01 05:00:00 JFK        1     1     5  39.0
##  6  2013 N24211  UA      2013-01-01 05:00:00 LGA        1     1     5  39.9
##  7  2013 N619AA  AA      2013-01-01 05:00:00 EWR        1     1     5  39.0
##  8  2013 N619AA  AA      2013-01-01 05:00:00 JFK        1     1     5  39.0
##  9  2013 N619AA  AA      2013-01-01 05:00:00 LGA        1     1     5  39.9
## 10  2013 N804JB  B6      2013-01-01 05:00:00 EWR        1     1     5  39.0
## # ... with 2,878 more rows, and 8 more variables: dewp <dbl>, humid <dbl>,
## #   wind_dir <dbl>, wind_speed <dbl>, wind_gust <dbl>, precip <dbl>,
## #   pressure <dbl>, visib <dbl>
```

### 5. Add `weather` information to the `flights2` dataset by matching only "time_hour" variable


```r
flights2 %>%
  left_join(weather, by = "time_hour")
```

```
## # A tibble: 2,888 x 18
##    year.x tailnum carrier time_hour           origin year.y month   day
##     <int> <chr>   <chr>   <dttm>              <chr>   <dbl> <dbl> <int>
##  1   2013 N14228  UA      2013-01-01 05:00:00 EWR      2013     1     1
##  2   2013 N14228  UA      2013-01-01 05:00:00 JFK      2013     1     1
##  3   2013 N14228  UA      2013-01-01 05:00:00 LGA      2013     1     1
##  4   2013 N24211  UA      2013-01-01 05:00:00 EWR      2013     1     1
##  5   2013 N24211  UA      2013-01-01 05:00:00 JFK      2013     1     1
##  6   2013 N24211  UA      2013-01-01 05:00:00 LGA      2013     1     1
##  7   2013 N619AA  AA      2013-01-01 05:00:00 EWR      2013     1     1
##  8   2013 N619AA  AA      2013-01-01 05:00:00 JFK      2013     1     1
##  9   2013 N619AA  AA      2013-01-01 05:00:00 LGA      2013     1     1
## 10   2013 N804JB  B6      2013-01-01 05:00:00 EWR      2013     1     1
## # ... with 2,878 more rows, and 10 more variables: hour <int>, temp <dbl>,
## #   dewp <dbl>, humid <dbl>, wind_dir <dbl>, wind_speed <dbl>,
## #   wind_gust <dbl>, precip <dbl>, pressure <dbl>, visib <dbl>
```

## Types of filtering join

### Let's filter tibbles using two filtering functions: `semi_join`, `anti_join`


### example for `semi_join`: All rows in `a` that have a match in `b`


```r
semi_join(a,b)
```

```
## Joining, by = "x1"
```

```
## # A tibble: 2 x 2
##   x1       x2
##   <chr> <int>
## 1 A         1
## 2 B         2
```

### example for `anti_join`: All rows in `a` that do not have a match in `b`


```r
anti_join(a,b)
```

```
## Joining, by = "x1"
```

```
## # A tibble: 1 x 2
##   x1       x2
##   <chr> <int>
## 1 C         3
```

### example of joinin by matching two variables (e.g., "x1", "x2") from both datasets `a` and `c`


```r
semi_join(a,c)
```

```
## Joining, by = c("x1", "x2")
```

```
## # A tibble: 1 x 2
##   x1       x2
##   <chr> <int>
## 1 A         1
```

## Types of Set Operations for two datasets

### Let's use three `set` functions: `intersect`, `union` and `setdiff`

### create two tibbles named `y` and `z`, similar to Data Wrangling Cheatsheet


```r
(y <-  tibble(x1 = LETTERS[1:3], x2 = 1:3))
```

```
## # A tibble: 3 x 2
##   x1       x2
##   <chr> <int>
## 1 A         1
## 2 B         2
## 3 C         3
```

```r
(z <- tibble(x1 = c("B", "C", "D"), x2 = 2:4))
```

```
## # A tibble: 3 x 2
##   x1       x2
##   <chr> <int>
## 1 B         2
## 2 C         3
## 3 D         4
```

### example for `intersect`: Rows that appear in both `y` and `z`


```r
semi_join(y,z)
```

```
## Joining, by = c("x1", "x2")
```

```
## # A tibble: 2 x 2
##   x1       x2
##   <chr> <int>
## 1 B         2
## 2 C         3
```

```r
intersect(y,z)
```

```
## # A tibble: 2 x 2
##   x1       x2
##   <chr> <int>
## 1 B         2
## 2 C         3
```

### example for `union`: Rows that appear in either or both `y` and `z`


```r
full_join(y,z)
```

```
## Joining, by = c("x1", "x2")
```

```
## # A tibble: 4 x 2
##   x1       x2
##   <chr> <int>
## 1 A         1
## 2 B         2
## 3 C         3
## 4 D         4
```

```r
union(y,z)
```

```
## # A tibble: 4 x 2
##   x1       x2
##   <chr> <int>
## 1 D         4
## 2 C         3
## 3 B         2
## 4 A         1
```

### example for `setdiff`: Rows that appear in `y` but not `z`. __Caution:__ `setdiff` for `y` to `z` and `z` to `y` are different.


```r
anti_join(y,z)
```

```
## Joining, by = c("x1", "x2")
```

```
## # A tibble: 1 x 2
##   x1       x2
##   <chr> <int>
## 1 A         1
```

```r
setdiff(y,z)
```

```
## # A tibble: 1 x 2
##   x1       x2
##   <chr> <int>
## 1 A         1
```

```r
anti_join(z,y)
```

```
## Joining, by = c("x1", "x2")
```

```
## # A tibble: 1 x 2
##   x1       x2
##   <chr> <int>
## 1 D         4
```

```r
setdiff(z,y)
```

```
## # A tibble: 1 x 2
##   x1       x2
##   <chr> <int>
## 1 D         4
```

### what happen if colnames are differentin `y` and `x`? Is there any error message and why?


```r
(x <- tibble(x1 = c("B", "C", "D"), x3 = 2:4))
```

```
## # A tibble: 3 x 2
##   x1       x3
##   <chr> <int>
## 1 B         2
## 2 C         3
## 3 D         4
```

```r
#union(z, x)
```

## Types of binding datasets

### Let's bind datasets by rows or column using two binding functions:

### example for `bind_rows`: Append `z` to `y` as new rows


```r
bind_rows(y,z)
```

```
## # A tibble: 6 x 2
##   x1       x2
##   <chr> <int>
## 1 A         1
## 2 B         2
## 3 C         3
## 4 B         2
## 5 C         3
## 6 D         4
```

### example for `bind_cols`: Append `z` to `y` as new columns. __Caution__: matches rows by position. Check colnames after binding.


```r
bind_cols(y, z)
```

```
## # A tibble: 3 x 4
##   x1       x2 x11     x21
##   <chr> <int> <chr> <int>
## 1 A         1 B         2
## 2 B         2 C         3
## 3 C         3 D         4
```

### what happen if colnames are different between `y` and `x` datasets?


```r
bind_rows(y, x)
```

```
## # A tibble: 6 x 3
##   x1       x2    x3
##   <chr> <int> <int>
## 1 A         1    NA
## 2 B         2    NA
## 3 C         3    NA
## 4 B        NA     2
## 5 C        NA     3
## 6 D        NA     4
```

```r
bind_cols(y, x)
```

```
## # A tibble: 3 x 4
##   x1       x2 x11      x3
##   <chr> <int> <chr> <int>
## 1 A         1 B         2
## 2 B         2 C         3
## 3 C         3 D         4
```

##Practice Exercises
Practice these concepts in the following exercises. It might help you to first identify the type of function you are applying.


### 1. Filter the rows of `flights2` by matching "year" and "time_hour" variables to `weather` dataset. Use both `semi_join()` and `anti_join()`


```r
flights2 %>%
  semi_join(weather, by = c("year", "time_hour"))
```

```
## # A tibble: 1,000 x 4
##     year tailnum carrier time_hour          
##    <int> <chr>   <chr>   <dttm>             
##  1  2013 N14228  UA      2013-01-01 05:00:00
##  2  2013 N24211  UA      2013-01-01 05:00:00
##  3  2013 N619AA  AA      2013-01-01 05:00:00
##  4  2013 N804JB  B6      2013-01-01 05:00:00
##  5  2013 N668DN  DL      2013-01-01 06:00:00
##  6  2013 N39463  UA      2013-01-01 05:00:00
##  7  2013 N516JB  B6      2013-01-01 06:00:00
##  8  2013 N829AS  EV      2013-01-01 06:00:00
##  9  2013 N593JB  B6      2013-01-01 06:00:00
## 10  2013 N3ALAA  AA      2013-01-01 06:00:00
## # ... with 990 more rows
```

```r
flights2 %>%
  anti_join(weather, by = c("year", "time_hour"))
```

```
## # A tibble: 0 x 4
## # ... with 4 variables: year <int>, tailnum <chr>, carrier <chr>,
## #   time_hour <dttm>
```

All flights2 rows have matching rows in weather

### 2. Can we apply `set` and `binding` funcions between `flights2` and `weather` datasets. Why and why not?


```r
flights2 %>%
  intersect(weather)
```

```
## Error in intersect_data_frame(x, y): not compatible: 
## - Cols in y but not x: `visib`, `pressure`, `wind_gust`, `wind_dir`, `dewp`, `wind_speed`, `hour`, `day`, `precip`, `humid`, `month`, `temp`, `origin`. 
## - Cols in x but not y: `tailnum`, `carrier`.
```

```r
bind_cols(flights2, weather)
```

```
## Error in cbind_all(x): Argument 2 must be length 1000, not 26115
```

```r
bind_rows(flights2, weather)
```

```
## # A tibble: 27,115 x 17
##     year tailnum carrier time_hour           origin month   day  hour  temp
##    <dbl> <chr>   <chr>   <dttm>              <chr>  <dbl> <int> <int> <dbl>
##  1  2013 N14228  UA      2013-01-01 05:00:00 <NA>      NA    NA    NA    NA
##  2  2013 N24211  UA      2013-01-01 05:00:00 <NA>      NA    NA    NA    NA
##  3  2013 N619AA  AA      2013-01-01 05:00:00 <NA>      NA    NA    NA    NA
##  4  2013 N804JB  B6      2013-01-01 05:00:00 <NA>      NA    NA    NA    NA
##  5  2013 N668DN  DL      2013-01-01 06:00:00 <NA>      NA    NA    NA    NA
##  6  2013 N39463  UA      2013-01-01 05:00:00 <NA>      NA    NA    NA    NA
##  7  2013 N516JB  B6      2013-01-01 06:00:00 <NA>      NA    NA    NA    NA
##  8  2013 N829AS  EV      2013-01-01 06:00:00 <NA>      NA    NA    NA    NA
##  9  2013 N593JB  B6      2013-01-01 06:00:00 <NA>      NA    NA    NA    NA
## 10  2013 N3ALAA  AA      2013-01-01 06:00:00 <NA>      NA    NA    NA    NA
## # ... with 27,105 more rows, and 8 more variables: dewp <dbl>,
## #   humid <dbl>, wind_dir <dbl>, wind_speed <dbl>, wind_gust <dbl>,
## #   precip <dbl>, pressure <dbl>, visib <dbl>
```

No! Columns are not all shared, and rows do not match

### 3. Let's create a tibble `p` with "x1" and "x2" coulmns and have duplicated element in "x1" column. Create another tibble `q` with "x1" and "x3" columns. Then apply `left_join` function `p` to `q` and `q` to `p`.


```r
p <- tribble(~x1, ~x2,
             "A", 1,
             "A", 2,
             "B", 3)
q <- tribble(~x1, ~x3,
             "A", 1,
             "B", 2,
             "C", 3)

left_join(p,q)
```

```
## Joining, by = "x1"
```

```
## # A tibble: 3 x 3
##   x1       x2    x3
##   <chr> <dbl> <dbl>
## 1 A         1     1
## 2 A         2     1
## 3 B         3     2
```

```r
left_join(q,p)
```

```
## Joining, by = "x1"
```

```
## # A tibble: 4 x 3
##   x1       x3    x2
##   <chr> <dbl> <dbl>
## 1 A         1     1
## 2 A         1     2
## 3 B         2     3
## 4 C         3    NA
```

