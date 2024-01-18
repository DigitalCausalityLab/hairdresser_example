library(shiny)
library(ggdag)
library(ggplot2)

# Shiny server function
shinyServer(function(input, output) {
  set.seed(123)
  FreundlichkeitMitarbeiter = sample(0:100, size = 500, replace = TRUE)
  QualitaetHaarschnitt = sample(0:100, size = 500, replace = TRUE)
  
  EinStern = ifelse((FreundlichkeitMitarbeiter + QualitaetHaarschnitt) <= 40, 1, 0)
  ZweiSterne = ifelse((FreundlichkeitMitarbeiter + QualitaetHaarschnitt) > 40 & (FreundlichkeitMitarbeiter + QualitaetHaarschnitt) <= 80, 2, 0)
  DreiSterne = ifelse((FreundlichkeitMitarbeiter + QualitaetHaarschnitt) > 80 & (FreundlichkeitMitarbeiter + QualitaetHaarschnitt) <= 120, 3, 0)
  VierSterne = ifelse((FreundlichkeitMitarbeiter + QualitaetHaarschnitt) > 120 & (FreundlichkeitMitarbeiter + QualitaetHaarschnitt) <= 160, 4, 0)
  FuenfSterne = ifelse((FreundlichkeitMitarbeiter + QualitaetHaarschnitt) > 160 & (FreundlichkeitMitarbeiter + QualitaetHaarschnitt) <= 200, 5, 0)
  Sternebewertung = EinStern + ZweiSterne + DreiSterne + VierSterne + FuenfSterne
  
  Datensatz = data.frame(FreundlichkeitMitarbeiter, QualitaetHaarschnitt, Sternebewertung)
  
  Teilmenge1 = subset(Datensatz, Sternebewertung == 1)
  Teilmenge2 = subset(Datensatz, Sternebewertung == 2)
  Teilmenge3 = subset(Datensatz, Sternebewertung == 3)
  Teilmenge4 = subset(Datensatz, Sternebewertung == 4)
  Teilmenge5 = subset(Datensatz, Sternebewertung == 5)
  
  RegressionDatensatz = lm(FreundlichkeitMitarbeiter ~ QualitaetHaarschnitt, Datensatz)
  RegressionTeilmenge1 = lm(FreundlichkeitMitarbeiter ~ QualitaetHaarschnitt, Teilmenge1)
  RegressionTeilmenge2 = lm(FreundlichkeitMitarbeiter ~ QualitaetHaarschnitt, Teilmenge2)
  RegressionTeilmenge3 = lm(FreundlichkeitMitarbeiter ~ QualitaetHaarschnitt, Teilmenge3)
  RegressionTeilmenge4 = lm(FreundlichkeitMitarbeiter ~ QualitaetHaarschnitt, Teilmenge4)
  RegressionTeilmenge5 = lm(FreundlichkeitMitarbeiter ~ QualitaetHaarschnitt, Teilmenge5)
  
  # Render the scatterplot
  output$scatterplot <- renderPlot({
    data <- switch(input$option,
                   "All salons" = Datensatz,
                   "Good review" = Teilmenge5,
                   "Bad review" = Teilmenge1,
                   "Very good review" = Teilmenge5,
                   "Very bad review" = Teilmenge1)
    
    plot(data$FreundlichkeitMitarbeiter, data$QualitaetHaarschnitt, xlab = "FreundlichkeitMitarbeiter", ylab = "QualitaetHaarschnitt")
    abline(lm(data$FreundlichkeitMitarbeiter ~ data$QualitaetHaarschnitt))
  })
  
  # Render the DAG plot
  output$dag <- renderPlot({
    data <- switch(input$option,
                   "All salons" = Datensatz,
                   "Good review" = Teilmenge5,
                   "Bad review" = Teilmenge1,
                   "Very good review" = Teilmenge5,
                   "Very bad review" = Teilmenge1)
    
    # Explicitly specify variable names in DAG formula
    dag_formula <- "F ~ S + Q"
    # Parse the formula
    dag <- dagify(as.formula(dag_formula))
    
    # Create DAG plot
    dag_plot <- ggdag(dag) + theme_dag_blank() +
      geom_dag_edges(edge_width = 1.5) + 
      geom_dag_point() +
      geom_dag_text(label = c(F = "F", S = "S", Q = "Q"))
    
    # Display the DAG plot
    dag_plot
  })
})
