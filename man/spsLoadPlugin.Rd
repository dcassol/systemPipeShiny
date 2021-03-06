% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/spsPlugin.R
\name{spsLoadPlugin}
\alias{spsLoadPlugin}
\alias{spsRemovePlugin}
\alias{spsNewPlugin}
\title{SPS plugin operations}
\usage{
spsLoadPlugin(
  plugin = "",
  app_path = getwd(),
  verbose = FALSE,
  third_party = FALSE,
  overwrite = 0,
  colorful = TRUE
)

spsRemovePlugin(
  plugin = "",
  app_path = getwd(),
  force = FALSE,
  verbose = FALSE,
  colorful = TRUE
)

spsNewPlugin(path, readme = TRUE, verbose = FALSE, colorful = TRUE)
}
\arguments{
\item{plugin}{character, a plugin name. It can also be a path in
\code{spsLoadPlugin} function  when if \code{third_party = TRUE}.}

\item{app_path}{the SPS project you want to load plugin to}

\item{verbose}{bool, show more information?}

\item{third_party}{bool, is this an official plugin?}

\item{overwrite}{one of 0, 1 or 2, if there are file conflicts, how to
handle conflict files, see details.}

\item{colorful}{bool, colorful message?}

\item{force}{bool, if plugin files found, confirm before remove?}

\item{path}{character string, path of where you want to create the plugin
directory, can be a non-existing location but make sure you have write
permission.}

\item{readme}{bool, created \emph{README.md} file?}
}
\value{
No return
}
\description{
\code{spsLoadPlugin()} is used to load an existing SPS plugin,
\code{spsRemovePlugin()} is to remove a loaded plugin, and \code{spsNewPlugin()} is
for developers to create a minimum plugin structure and required files.
}
\details{
\subsection{General}{
\itemize{
\item Make sure there is a 'config/tabs.csv' file in your SPS project when you
load the plugin.
\item You can just use \code{spsLoadPlugin()} without any argument to see
what are the plugin options.
\item If there is any file conflicts when loading plugins, please see the
app structure tree and refer to the legend below the tree to help you resolve
conflicts. Overwriting current files is not recommended. Rename conflict
files and compare them after loading the plugin will be better.
\item When a plugin is removed, only tab files from that plugin are removed and
entries on \emph{config/tabs.csv} are removed. Other files come from the plugin
will not be removed.
}
}

\subsection{overwrite mode}{
\itemize{
\item 0, if there is any conflict, abort
\item 1, overwrite all overlapping files
\item 2, ignore conflict files, only copy new files
}
}

\subsection{Building a plugin}{
\itemize{
\item When adding new tabs to a plugin, it will be better to set working
directory to \emph{PLUGIN_ROOT/inst/app}. Tab files should go into
\emph{PLUGIN_ROOT/inst/app/R}.
\item Any additional files in \emph{PLUGIN_ROOT/inst/app} except the \emph{config/tabs.csv}
will also be copied to users' project.
\item Tab files will be checked and two functions in the tab file are expected:
\code{tabIDUI} and \code{tabIDServer}. Other files will not be checked for content.
\item For a plugin to work, \emph{PLUGIN_ROOT/inst/app/config/tabs.csv} is required,
and tab files listed in this \emph{tabs.csv} are also required to be put inside
\emph{PLUGIN_ROOT/inst/app/R}. \emph{PLUGIN_ROOT/inst/app/welcome.txt} is optional. If
this file exists, content will be \code{cat} to console when plugin is loaded.
}
}
}
\examples{
# see what official plugins you can install:
spsLoadPlugin()
# create a project
spsInit(project_name = "testProject",
        change_wd = FALSE,
        open_files = TRUE,
        overwrite = TRUE)
# create a new plugin
spsNewPlugin(path = "testPlugin")
# add some tabs to the plugin
# tabs
plugin_path <- file.path("testPlugin", "inst", "app")
newTabData("data_a",
           app_path = plugin_path,
           plugin = "testPlugin",
           reformat = FALSE,
           open_file = FALSE)
newTabPlot("plot_a",
           app_path = plugin_path,
           plot_data = list(makePlotData(receive_datatab_ids = 'data_a',
                                    app_path = plugin_path)),
           plugin = "testPlugin",
           reformat = FALSE,
           open_file = FALSE)
# load the plugin, the plugin is not published, so `third_party = TRUE`
spsLoadPlugin(plugin = "testPlugin",
              app_path = "testProject",
              third_party = TRUE,
              overwrite = 1)
# check if the plugin is added
# You should see `tab_vs_data_a.R` and `tab_vs_plot_a.R`
list.files(file.path("testProject", "R"))
# check if tab files are registered
# You should see the two new records
vroom::vroom(file.path("testProject", "config", "tabs.csv"),
             comment = "#") \%>\% tail()
# now remove the plugin
spsRemovePlugin(plugin = "testPlugin", app_path = "testProject", force = TRUE)
# let check these files again:
list.files(file.path("testProject", "R"))
vroom::vroom(file.path("testProject", "config", "tabs.csv"),
             comment = "#") \%>\% tail()
}
