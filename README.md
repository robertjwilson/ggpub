Summary
--------

Introducing a ggplot2 theme to make it easier to produce figures that meet the format requirements of academic journals.

Summary
--------

Install the development version of ggpub using [devtools](https://github.com/hadley/devtools):

```
library(devtools)
install_github("robertwilson190/ggpub")
```
Basic usage
--------
The theme theme_pub is designed to make creating journal-ready figures using ggplot2 relatively pain free. I will begin with data from iris data set. Here is what it looks like using ggplot2's defaults.

``` r
library(ggplot2)

ggplot(iris, aes(Sepal.Length, Sepal.Width))+
	geom_point()
```
![](read_me_1.png)

This kind of plot will be rejected by most journals. For a start many hold to the outdated idea that everything needs a white background. There are some options within ggplot2. For example, here is theme_bw:

``` r
ggplot(iris, aes(Sepal.Length, Sepal.Width))+
	geom_point()+
	theme_bw()
```
![](read_me_2.png)

