library(shiny)
library(ggdag)
library(ggplot2)
library(gt)
library(broom)

# UI code
source("/Users/sauravbania/Stats Job/Collider Bias Hairdresser/Packages_Color.R")

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
          border-bottom-color:#ffda3e;
          border-left-color:#ffda3e;
          border-right-color:#ffda3e;
          border-top-color:#ffda3e;
        }
      "))),
      withMathJax(),
      chooseSliderSkin(slider_skin, color = slider_color),
      tabItems(
        tabItem(tabName = "collider",
                h2("Collider Bias: Hairdresser Example"),
                p("This app illustrates the Collider Bias in the context of the Hairdresser Example from 
                  'Collider Bias anhand eines Simulationsbeispiels by A. Yousefi Malekrudi and A. Duman'. 
                  This interactive application explores the relationship between the friendliness of staff 
                  (FreundlichkeitMitarbeiter), the quality of haircuts (QualitätHaarschnitt), and the resulting 
                  star ratings in hairdressing salons. This analysis aims to uncover insights into the factors 
                  influencing customer reviews and the potential collider bias within specific star rating categories."),
                h3("Data Simulation"),
                p("In this app, we simulate a dataset representing customer experiences in hairdressing salons. 
                  The variables 'FreundlichkeitMitarbeiter(Friendliness)' and 'QualitaetHaarschnitt (Quality of Haircut)' capture the friendliness of staff 
                  and the quality of haircuts, respectively. The star ratings (Sternebewertung) are derived based on 
                  these factors, providing a comprehensive view of customer satisfaction."),
                h3("Scatter plot and Regression"),
                p("The scatterplot visualizes the relationship between friendliness and haircut quality. 
                  Users can choose different options, such as viewing data for all salons or filtering by specific star 
                  ratings (good, bad, very good, or very bad). The accompanying regression line helps distinguish the overall 
                  trend within the selected subset, helping us in the interpretation of the data."),
                h3("Directed Acyclic Graph (DAG) and Collider Bias"),
                p("This DAG illustrates the causal relationships between friendliness (F), star ratings (S), 
                  and haircut quality (Q). The DAG helps users understand the pathways through which these variables are 
                  connected and explores the concept of collider bias. By delving into specific subsets of the data, 
                  users can assess the presence of collider bias. Collider bias happens when we focus on a shared outcome, 
                  and it influences the connections we observe between different factors The subset analyses (Teilmenge1 to 
                  Teilmenge5) allow for a detailed exploration of customer satisfaction within different star rating categories."),
                # Move scatter plot to the top right corner
                fluidRow(
                  box(
                    fluidRow(
                      box(
                        title = "Options",
                        solidHeader = TRUE,
                        status = "primary",
                        background = "black",
                        selectInput("option", "Option", c("All salons", "Good review", "Bad review", "Very good review", "Very bad review")),
                        width = 12
                      ),
                      box(
                        title = "Scatter Plot",
                        solidHeader = TRUE,
                        status = "success",
                        plotOutput("scatterplot", height = 300),
                        width = 12
                      )
                    ),
                    width = 4
                  ),
                  # DAG Plot
                  box(
                    title = "DAG Plot",
                    status = "info",
                    solidHeader = TRUE,
                    plotOutput("dag", height = 450),
                    width = 8
                  )
                ),
                # Conclusion
                fluidRow(
                  box(
                    h3("Conclusion"),
                    p("In conclusion, the Collider Bias: Hairdresser Shiny App offers a comprehensive and interactive 
                      exploration of the factors influencing customer reviews in the hairdressing industry. As you navigate 
                      through the scatterplot, regression outputs, and DAG plot, consider the implications of collider bias
                      and gain insights into the complex interplay between friendliness, haircut quality, and star ratings."),
                    width = 12
                  )
                )
        )
      )
    )
  )
)
