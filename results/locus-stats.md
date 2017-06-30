---
title: "Locus Statistics"
output: 
  html_notebook:
    toc: true
editor_options: 
  chunk_output_type: inline
---



# Purpose

This will tabulate statistics per locus for presentation in a table.


```r
library("poppr")
```

```
## Loading required package: adegenet
```

```
## Loading required package: ade4
```

```
## 
##    /// adegenet 2.1.0 is loaded ////////////
## 
##    > overview: '?adegenet'
##    > tutorials/doc/questions: 'adegenetWeb()' 
##    > bug reports/feature requests: adegenetIssues()
```

```
## This is poppr version 2.4.1. To get started, type package?poppr
## OMP parallel support: available
```

```r
load(file.path(PROJHOME, "data", "sclerotinia_16_loci.rda"))
```


```r
makerange <- . %>% as.integer() %>% range() %>% paste(collapse = "-")

ranges <- map_chr(alleles(dat11), makerange)
```

```
Error in map_chr(alleles(dat11), makerange): could not find function "map_chr"
```

```r
ranges <- c(ranges, alleles(dat11) %>% unlist(use.names = FALSE) %>% makerange)
```

```
Error in eval(expr, envir, enclos): object 'ranges' not found
```

```r
locus_table(dat11, information = FALSE) %>% 
  as.data.frame() %>%
  rownames_to_column("Locus") %>%
  mutate(Locus = gsub("\\([FH]\\)", "", Locus)) %>%
  add_column(Range = ranges) %>%
  select(Locus, Range, allele, Hexp, Evenness) %>%
  mutate(allele = round(allele, 2)) %>%
  rename(`$H_{exp}$` = Hexp, `No. alleles` = allele) %>%
  huxtable::as_huxtable(add_colnames = TRUE) %>%
  huxtable::set_number_format(1:12, 3, 0) %>%
  huxtable::set_number_format(everywhere, 4:5, 2) %>%
  huxtable::set_align(everywhere, 3:5, "right") %>%
  huxtable::set_col_width(c(0.06, 0.07, 0.123, 0.09, 0.08)) %>%
  huxtable::print_md(max_width = 47)
```

```
Error in rownames_to_column(., "Locus"): could not find function "rownames_to_column"
```


## Session Information


```r
options(width = 100)
devtools::session_info()
```

```
## Session info --------------------------------------------------------------------------------------
```

```
##  setting  value                       
##  version  R version 3.4.0 (2017-04-21)
##  system   x86_64, darwin15.6.0        
##  ui       X11                         
##  language (EN)                        
##  collate  en_US.UTF-8                 
##  tz       America/Chicago             
##  date     2017-06-29
```

```
## Packages ------------------------------------------------------------------------------------------
```

```
##  package     * version date       source                                  
##  ade4        * 1.7-6   2017-03-23 CRAN (R 3.4.0)                          
##  adegenet    * 2.1.0   2017-05-06 Github (thibautjombart/adegenet@e07c139)
##  ape           4.1     2017-02-14 CRAN (R 3.4.0)                          
##  assertr       2.0.2.2 2017-06-06 CRAN (R 3.4.0)                          
##  assertthat    0.2.0   2017-04-11 CRAN (R 3.4.0)                          
##  base        * 3.4.0   2017-04-21 local                                   
##  bindr         0.1     2016-11-13 CRAN (R 3.4.0)                          
##  bindrcpp      0.2     2017-06-17 CRAN (R 3.4.0)                          
##  boot          1.3-19  2017-04-21 CRAN (R 3.4.0)                          
##  cluster       2.0.6   2017-03-16 CRAN (R 3.4.0)                          
##  coda          0.19-1  2016-12-08 CRAN (R 3.4.0)                          
##  colorspace    1.3-2   2016-12-14 CRAN (R 3.4.0)                          
##  compiler      3.4.0   2017-04-21 local                                   
##  datasets    * 3.4.0   2017-04-21 local                                   
##  DBI           0.7     2017-06-18 CRAN (R 3.4.0)                          
##  deldir        0.1-14  2017-04-22 CRAN (R 3.4.0)                          
##  devtools      1.13.2  2017-06-02 CRAN (R 3.4.0)                          
##  digest        0.6.12  2017-01-27 CRAN (R 3.4.0)                          
##  dplyr         0.7.1   2017-06-22 CRAN (R 3.4.0)                          
##  evaluate      0.10    2016-10-11 CRAN (R 3.4.0)                          
##  expm          0.999-2 2017-03-29 CRAN (R 3.4.0)                          
##  ezknitr       0.6     2016-09-16 CRAN (R 3.4.0)                          
##  fastmatch     1.1-0   2017-01-28 CRAN (R 3.4.0)                          
##  gdata         2.18.0  2017-06-06 CRAN (R 3.4.0)                          
##  ggplot2       2.2.1   2016-12-30 CRAN (R 3.4.0)                          
##  glue          1.1.1   2017-06-21 CRAN (R 3.4.0)                          
##  gmodels       2.16.2  2015-07-22 CRAN (R 3.4.0)                          
##  graphics    * 3.4.0   2017-04-21 local                                   
##  grDevices   * 3.4.0   2017-04-21 local                                   
##  grid          3.4.0   2017-04-21 local                                   
##  gtable        0.2.0   2016-02-26 CRAN (R 3.4.0)                          
##  gtools        3.5.0   2015-05-29 CRAN (R 3.4.0)                          
##  htmltools     0.3.6   2017-04-28 CRAN (R 3.4.0)                          
##  httpuv        1.3.3   2015-08-04 CRAN (R 3.4.0)                          
##  igraph        1.0.1   2015-06-26 CRAN (R 3.4.0)                          
##  knitr       * 1.16    2017-05-18 CRAN (R 3.4.0)                          
##  lattice       0.20-35 2017-03-25 CRAN (R 3.4.0)                          
##  lazyeval      0.2.0   2016-06-12 CRAN (R 3.4.0)                          
##  LearnBayes    2.15    2014-05-29 CRAN (R 3.4.0)                          
##  magrittr      1.5     2014-11-22 CRAN (R 3.4.0)                          
##  MASS          7.3-47  2017-04-21 CRAN (R 3.4.0)                          
##  Matrix        1.2-10  2017-04-28 CRAN (R 3.4.0)                          
##  memoise       1.1.0   2017-04-21 CRAN (R 3.4.0)                          
##  methods     * 3.4.0   2017-04-21 local                                   
##  mgcv          1.8-17  2017-02-08 CRAN (R 3.4.0)                          
##  mime          0.5     2016-07-07 CRAN (R 3.4.0)                          
##  munsell       0.4.3   2016-02-13 CRAN (R 3.4.0)                          
##  nlme          3.1-131 2017-02-06 CRAN (R 3.4.0)                          
##  parallel      3.4.0   2017-04-21 local                                   
##  pegas         0.10    2017-05-03 CRAN (R 3.4.0)                          
##  permute       0.9-4   2016-09-09 CRAN (R 3.4.0)                          
##  phangorn      2.2.0   2017-04-03 CRAN (R 3.4.0)                          
##  pkgconfig     2.0.1   2017-03-21 CRAN (R 3.4.0)                          
##  plyr          1.8.4   2016-06-08 CRAN (R 3.4.0)                          
##  poppr       * 2.4.1   2017-04-14 CRAN (R 3.4.0)                          
##  quadprog      1.5-5   2013-04-17 CRAN (R 3.4.0)                          
##  R.methodsS3   1.7.1   2016-02-16 CRAN (R 3.4.0)                          
##  R.oo          1.21.0  2016-11-01 CRAN (R 3.4.0)                          
##  R.utils       2.5.0   2016-11-07 CRAN (R 3.4.0)                          
##  R6            2.2.2   2017-06-17 cran (@2.2.2)                           
##  Rcpp          0.12.11 2017-05-22 cran (@0.12.11)                         
##  reshape2      1.4.2   2016-10-22 CRAN (R 3.4.0)                          
##  rlang         0.1.1   2017-05-18 CRAN (R 3.4.0)                          
##  scales        0.4.1   2016-11-09 CRAN (R 3.4.0)                          
##  seqinr        3.3-6   2017-04-06 CRAN (R 3.4.0)                          
##  shiny         1.0.3   2017-04-26 CRAN (R 3.4.0)                          
##  sp            1.2-4   2016-12-22 CRAN (R 3.4.0)                          
##  spdep         0.6-13  2017-04-25 CRAN (R 3.4.0)                          
##  splines       3.4.0   2017-04-21 local                                   
##  stats       * 3.4.0   2017-04-21 local                                   
##  stringi       1.1.5   2017-04-07 CRAN (R 3.4.0)                          
##  stringr       1.2.0   2017-02-18 CRAN (R 3.4.0)                          
##  tibble        1.3.3   2017-05-28 CRAN (R 3.4.0)                          
##  tools         3.4.0   2017-04-21 local                                   
##  utils       * 3.4.0   2017-04-21 local                                   
##  vegan         2.4-3   2017-04-07 CRAN (R 3.4.0)                          
##  withr         1.0.2   2016-06-20 CRAN (R 3.4.0)                          
##  xtable        1.8-2   2016-02-05 CRAN (R 3.4.0)
```