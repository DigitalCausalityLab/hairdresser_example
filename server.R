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
                   "Very good review" = Teilmenge5,
                   "Good review" = Teilmenge4,
                   "Okay" = Teilmenge3,
                   "Bad review" = Teilmenge2,
                   "Very bad review" = Teilmenge1)
    
    plot(data$FreundlichkeitMitarbeiter, data$QualitaetHaarschnitt, xlab = "Friendliness", ylab = "Quality", xlim = c(0,100),ylim = c(0,100))
    abline(lm(data$FreundlichkeitMitarbeiter ~ data$QualitaetHaarschnitt))
  })
  
  # Render the DAG plot
  output$dag <- renderPlot({
    if (input$option == "All salons") {
      dag <- collider_unconditional
    } else {
      ## Control for Movie star
      dag <- collider_conditional
    }
    dag
  })
})
