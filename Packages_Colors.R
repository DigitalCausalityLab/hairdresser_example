#Loading the required packages ####
packages <- c("shiny","ggplot2", "EnvStats", "shinyWidgets","shinydashboard",
              "latex2exp","dplyr", "plotly","MASS", "mvtnorm", "gtsummary", "gt", "ggdag", "dagitty")

#installing new packages
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())))  
}
#load and attach packages
if (length(setdiff(packages,names(sessionInfo()$otherPkgs))) > 0) {
  lapply(setdiff(packages,names(sessionInfo()$otherPkgs)),
         require, character.only = TRUE)
}

#defining certain colors and methods ####
dashboard_skin <- "black"
loading_method <- "cube-grid"
loading_color <- "#2980B9"
slider_color <- "#E74C3C"
slider_skin <- "Modern"
PAGE_TITLE <- "Approximation"

linecol1 <- "black"
linecol2 <- "Forestgreen"
linecol3 <- "blue"
linecol4 <- "red"

boxcol_1 <- "danger"
boxcol_2 <- "primary"

#logo ####
dbHeader <- dashboardHeader()
dbHeader$children[[2]]$children <-  tags$a(href='https://www.bwl.uni-hamburg.de/statistik',
                                           tags$img(src='/Users/sauravbania/Stats Job/Fundamental Problem/logo.png',
                                                    height = 100, width = 200))

# define the body ####
body_col <- '/* logo */
.skin-blue .main-header .logo {
background-color: #f4b943;
}
/* logo when hovered */
.skin-blue .main-header .logo:hover {
background-color: #f4b943;
}
/* navbar (rest of the header) */
.skin-blue .main-header .navbar {
background-color: #f4b943;
}
/* main sidebar */
.skin-blue .main-sidebar {
background-color: #f4b943;
}
/* active selected tab in the sidebarmenu */
.skin-blue .main-sidebar .sidebar .sidebar-menu .active a{
background-color: #ff0000;
}
/* other links in the sidebarmenu */
.skin-blue .main-sidebar .sidebar .sidebar-menu a{
background-color: #00ff00;
color: #000000;
}
/* other links in the sidebarmenu when hovered */
.skin-blue .main-sidebar .sidebar .sidebar-menu a:hover{
background-color: #ff69b4;
}
/* toggle button when hovered  */
.skin-blue .main-header .navbar .sidebar-toggle:hover{
background-color: #ff69b4;
}
/* body */
.content-wrapper, .right-side {
background-color: #EAEDED;
}'
