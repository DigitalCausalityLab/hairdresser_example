library(shiny)
library(ggdag)
library(gt)
library(broom)

# UI code
source("Packages_Colors.R")

shinyUI(
  dashboardPage(
    title = "Collider Bias: Hairdresser",
    skin = dashboard_skin,
    dbHeader,
    dashboardSidebar(
      sidebarMenu(
        menuItem("Collider Bias", tabName = "collider", icon = icon("project-diagram")),
        menuItem("Code", tabName = "code", icon = icon("code")),
        menuItem("References", tabName = "references", icon = icon("book"))
      )
    ),
    dashboardBody(
      tags$head(tags$style(HTML(
        ".box.box-solid.box-primary>.box-header {
          color:#fff;
          background:#000000
        }
        .box.box-solid.box-primary{
          border-bottom-color:#000000;
          border-left-color:#000000;
          border-right-color:#000000;
          border-top-color:#000000;
        }
      "))),
      withMathJax(),
      chooseSliderSkin(slider_skin, color = slider_color),
      # Move scatter plot to the top right corner
      fluidRow(
        column(
          width = 8,
          box(
            title = "Scatter Plot",
            solidHeader = TRUE,
            status = "primary",
            selectInput("option", "Option", c("All salons", "Good review", "Bad review", "Very good review", "Very bad review")),
            plotOutput("scatterplot", height = 450)
          )
        ),
        column(
          width = 8,
          box(
            title = "DAG Plot",
            status = "primary",
            solidHeader = TRUE,
            plotOutput("dag", height = 450)
          )
        )
      )
    )
  )
)
