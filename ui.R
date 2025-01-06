
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
      # Layout option defined in "R/Packages_Colors.R"
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
        }"),
        HTML("
        .box.box-solid.box-success>.box-header {
        color:#000000;
        background:#ffda3e
        }
        .box.box-solid.box-success{
        border-bottom-color:#ffda3e;
        border-left-color:#ffda3e;
        border-right-color:#ffda3e;
        border-top-color:#ffda3e;
        }"))),
      # Layout for math formula
      withMathJax(),
      chooseSliderSkin(slider_skin, color = slider_color),
      tabItems(
        tabItem(tabName = "collider",
                h2("Hairdresser Example: Collider Bias"),
                p("This app illustrates the collider bias in a hairdresser example.
                How do you choose your hairdresser? Many people look at online reviews
                and go only to top-rated hair salons and then realize: Why are hairdressers never
                friendly and bad at the same time? Should I better not trust a friendly hairdresser?"),
                
                # Left column: Text
                fluidRow(
                  column(
                    width = 7,
                    h2("Better Don't Trust a Friendly Hairdresser?"),
                    p("The reason why people might find a negative association between friendliness and quality of the haircut
                    is because of the underlying selection mechanisms. Remember, we selected a hairsalon based on a good rating in terms of online
                    reviews. There are basically two reasons why customers rate a hair salon high: Either the hairdresser was
                    a very nice person and customers enjoyed the conversations with him/her or she/he gave a good haircut.
                    These selection mechanism lead to the unexpected correlation, which we can confirm in a simulated data example."),
                    h3("Data Simulation"),
                    p("In this app, we simulate a dataset representing customer experiences in hairdressing salons. 
                      The variables 'Friendliness' and 'Quality of Haircut' capture the friendliness of staff 
                      and the quality of haircuts, respectively. The star ratings are derived based on 
                      these factors, providing a comprehensive view of customer satisfaction."),
                    h3("Scatter plot and Regression"),
                    p("The scatterplot visualizes the relationship between friendliness and haircut quality. 
                      Users typically only look at top ratings. The accompanying regression line helps distinguish the overall 
                      trend within the selected subset, helping us in the interpretation of the data.")
                  ),
                column(
                  width = 5,
                  img(src = "meme_hairdresser.jpg", style = "max-width:100%; height:auto;")
                )
                ),
                h3("Directed Acyclic Graph (DAG) and Collider Bias"),
                p("This DAG illustrates the causal relationships between friendliness (F), star ratings (S), 
                  and haircut quality (Q). The DAG helps users understand the pathways through which these variables are 
                  connected and explores the concept of collider bias. By delving into specific subsets of the data, 
                  users can assess the presence of collider bias. Collider bias happens when we focus on a shared outcome, 
                  and it influences the connections we observe between different factors. The subset analyses
                  allow for a detailed exploration of customer satisfaction within different star rating categories."),
                # Move scatter plot to the top right corner
                fluidRow(
                  box(
                    fluidRow(
                      box(
                        title = "Subset of Hair Salons",
                        solidHeader = TRUE,
                        status = "primary",
                        background = "black",
                        selectInput("option", "Subset of hair salons", c("All salons","Very good review", "Good review", "Okay", "Bad review",  "Very bad review")),
                        width = 12
                      )),
                      width = 4),
                      # ToDo! Move scatter plot on the right!
                  box(
                    title = "Scatter Plot",
                    solidHeader = TRUE,
                    status = boxcol_2,
                    plotOutput("scatterplot", height = 450),
                    width = 4
                      ),
                  # DAG Plot
                  # TODO: Fix dag!
                  box(
                    title = "DAG",
                    status = boxcol_2,
                    solidHeader = TRUE,
                    plotOutput("dag", height = 450),
                    width = 4
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
        ),
        tabItem(tabName = "code",
                h2("Code"),
                p("The code is available at the GitHub repository",
                  tags$a("https://github.com/DigitalCausalityLab/hairdresser_example.", href="https://github.com/DigitalCausalityLab/hairdresser_example")
                ),
                p("In case you find a bug or have suggestion for improvements, please open an issue in",
                  tags$a("GitHub.", href = "https://github.com/DigitalCausalityLab/hairdresser_example/issues")
                )
        ),
        tabItem(tabName = "references",
                h2("References"),
                p("Duman, Alper and Kabiri, Amir, 2023. “Collider Bias: The Hairdresser Example.” A student project for the Digital Causality Lab.")
      )
    )
  )
)
)