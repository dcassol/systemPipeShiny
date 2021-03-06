
# systemPipeShiny <img src="https://github.com/systemPipeR/systemPipeShiny-book/blob/master/img/sps.png?raw=true" align="right" height="139" />

<!-- badges: start -->
![R-CMD-check](https://github.com/systemPipeR/systemPipeShiny/workflows/R-CMD-check/badge.svg)
<!-- badges: end -->

`systemPipeShiny` is a framework for workflow management and data visualization. 
This tool is under devleopment, you can install it from Github.

An online demo of [systempipeShiny](https://tgirke.shinyapps.io/systemPipeShiny/). 
This application is hosted by a small server. Please do not use it for production activities. 
Heavy tasks will crash it and disconnect you from it. 

## Installation

You can install the released version of `systemPipeShiny` from Github with:

``` r
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("systemPipeR/systemPipeShiny", build_vignettes=TRUE, dependencies=TRUE)
```

If you are on Linux, you also need 

```
sudo apt-get install libcurl4-openssl-dev
sudo apt-get install libv8-dev
sudo apt-get install libxm12-dev
sudo apt-get install libssl-dev
```

## Setup

To start to use SPS

``` r
library(systemPipeShiny)
spsInit()
```

Then there should be a project folder created for you. By default, it is named `SPS_`+`DATE`. 
Your working directory should be set inside that project folder automatically. 
If you are using Rstudio, three main files will be opened for you: `global.R`, `ui.R` and `server.R`. 
Now you can just run the app by type `shiny::runApp()` in console or click on the green `> Run App` 
button on top right corner of the any these 3 files in Rstudio. 
In your global.R, scroll down to the bottom, you should see:


``` r
sps_app <- sps(
    vstabs = "",
    server_expr = {
        msg("Custom expression runs -- Hello World", "GREETING", "green")
    }
)
```

This is the SPS main function. You can load/unload tabs by providing tab IDs in `vstabs` argument, like 
`c("tab1", "tab2)`. See `config/tabs.csv` in your project folder for what tabs IDs can be load and other 
tab information. 

### Load custom new tabs
**Experimental**

After you have created your SPS project by the `spsInit` function, you can use `newTabData` to create a data tab 
and use `newTabPlot` to create a plot tab.

```r
newTabData(
    tab_id = "data_new", 
    tab_displayname = "my first data tab",
    prepro_methods = list(makePrepro(label = "do nothing",
                                     plot_options = "plot_new"))
)
newTabPlot(
    tab_id = "plot_new",
    tab_displayname = "my first plot tab",
    plot_data = list(makePlotData(dataset_label = "Data from my new tab",
                                  receive_datatab_ids = "data_new"))
           )
```
This code should generate a new data tab called *data_new* with a label *my first data tab* (what 
you see on the UI), and a new plot tab `plot_new`.

The important arg `plot_options = "plot_new"` is saying this data tab can make a plot, and the 
plot tab ID is "plot_new". On the plot tab similarly, `receive_datatab_ids = "data_new"` tells 
the framework this plot tab need to receive data from data tab `data_new`. In this way, we connect 
the data tab and the plot tab with each other. Of course, one data tab can link to multiple 
plot tabs and a plot tab can receive data from multiple data tabs too. Just specify the 
tab IDs by a vector `c(xx, xx)`.

Tabs are not loaded at this point, you need to specify you do want to load them by adding them 
to the app main function on the `global.R` file. Then launch the app as usually. New tab files 
are automatically created under your R folder, registered to your `config/tabs.csv` and 
sourced automatically.

``` r
sps_app <- sps(
    vstabs = c("data_new", "plot_new"), # add new tab IDs here
    server_expr = {
        msg("Custom expression runs -- Hello World", "GREETING", "green")
    }
)
```
If you don't want any tab file, use `removeSpsTab("TAB_ID")` to remove a tab. It will remove the R 
file and delete information on your `config/tabs.csv` file. 


Functions are experimental, we will update the help files and examples soon. 

## Internal 

<details>
<summary><b>
Click to expand the list of internal notes.
</b></summary>  

### Run to update the website (./docs/ folder)

``` r
pkgdown::build_site()
```

### Running roxygen

```r
roxygen2::roxygenise()
```

### ToDo List
 - Documentation showing how to deploy app on user shiny.io account
 - Documentation describing all the features
  - Setting up the data
  - Launching the interface

</details>

