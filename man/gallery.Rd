% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/spsUIcollections.R
\name{gallery}
\alias{gallery}
\title{A shiny gallery component}
\usage{
gallery(
  Id = NULL,
  title = "Gallery",
  title_color = "#0275d8",
  texts,
  hrefs,
  images,
  image_frame_size = 4
)
}
\arguments{
\item{Id}{ID of this gallery}

\item{title}{Title of gallery}

\item{title_color}{Title color}

\item{texts}{label under each image}

\item{hrefs}{link when clicking each}

\item{images}{image source,}

\item{image_frame_size}{integer, 1-12, this controls width}
}
\value{
a div element
}
\description{
\code{texts}, \code{hrefs}, \code{images} Must have the same length
Must be used with Bootstrap3 and sps.css file
}
\examples{
if(interactive()){
    texts <- c("p1", "p2", "p3", "p4", "p5")
    hrefs <- c("https://unsplash.it/1200/768.jpg?image=251",
               "https://unsplash.it/1200/768.jpg?image=252",
               "https://unsplash.it/1200/768.jpg?image=253",
               "https://unsplash.it/1200/768.jpg?image=254",
               "https://unsplash.it/1200/768.jpg?image=255")
    images <- c("https://unsplash.it/600.jpg?image=251",
                "https://unsplash.it/600.jpg?image=252",
                "https://unsplash.it/600.jpg?image=253",
                "https://unsplash.it/600.jpg?image=254",
                "https://unsplash.it/600.jpg?image=255")
    library(shiny)

    ui <- fluidPage(
        useSps(),
        gallery(texts = texts, hrefs = hrefs, images = images)
    )

    server <- function(input, output, session) {

    }

    shinyApp(ui, server)
}
}
