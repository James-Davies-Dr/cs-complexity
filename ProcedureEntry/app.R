library(shiny)
library(shinydashboard)
library(tidyverse)
library(googlesheets4)
library(lubridate)
library(gt)



#### Goals ####
## 1) A spreadsheet containing the information I'm interested in
## 2) A way to enter that information easily (Shiny)
## 3) A way to view that information easily including cool gfx


  
ui <- dashboardPage(
  dashboardHeader(title = "Caesarean Section Logbook"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Start Here", tabName = "dash0"),
      menuItem("View Latest Data", tabName = "dash1"),
      menuItem("Upload New Case", tabName = "dash2")
      
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "dash0",
              fluidPage(
                titlePanel(h1("Introduction & Welcome")),
                column(4,
                       p("Here you can see CS cases completed so far, and add info for new cases. NB this tab will not contain any reactive data and so is always rendered."))
                
      )
      )
    ),
      
      
      tabItem(tabName = "dash1",
              fluidPage(
                titlePanel(h1("See cases uploaded so far")),
                column(4,
                       p("insert text here")),
                box(
                  gt_output(outputId = "cs_data_table"))
                
              )),
      
      
      
      tabItem(tabName = "dash2",
              fluidPage(
              titlePanel(h1("Upload a new case")),
              box(
                  textInput("PatientID", label = "Patient ID"), 
                  dateInput("date", label = "Date of CS", format = "dd-M-yyyy", startview = "month"),
                  numericInput("BMI", label = "BMI", value = 25, min = 15, max = 100, step = 1),
                  numericInput("Age", label = "Maternal Age", value = 30, min = 15, max = 60, step = 1),
                  numericInput("Parity", label = "Parity", value = 0, min = 0, max = NA, step = 1),
                  numericInput("Gestation", label = "Gestation (Weeks)", value = 39, min = 22, max = 43, step = 1),
                  textInput("Indication", label = "Indication"),
                  
                  
                  width = 4),
              box(numericInput("PreviousCS", label = "Previous CS", value = 0, min = 0, max = NA, step = 1),
                  textAreaInput("PreviousSurgery", label = "Any Previous Surgery excluding CS"),
                  radioButtons("FullDilatation", label = "Fully Dilated?", choices = c("Yes", "No"), selected = "No"),
                  radioButtons("LowerSegmentFibroids", label = "Fibroids in lower segment?", choices = c("Yes", "No"), selected = "No"),
                  radioButtons("Multiple", label = "Multiple Pregnancy", choices = c("Singleton", "DCDA", "MCDA", "MCMA", "Triplets or More"), selected = "Singleton"),
                  width = 4),
              box(radioButtons("Placenta", label = "Placental Location", 
                               choices = c("High", "Low anterior", "Low but not anterior", "Complete Praevia",
                                           "Accreta", "Increta", "Percreta"), selected = "High"),
                  radioButtons("Lie", label = "Fetal Lie", choices = c("Longitudinal", "Oblique", "Transverse")),
                  radioButtons("Presentation", label = "Presentation", choices = c("Cephalic", "Breech", "Brow", "Face", "Shoulder", "Arm")),
                  
                  
                  numericInput("BloodLoss", label = "Blood loss to nearest 100mls", value = 500, min = 0, max = NA, step = 100),
                  width = 4),
              actionButton("Submit", label = "Upload")
              
              )
              
              
              
              )
      )
      )
      
      
      
    
  

server <- function(input, output) {
  
####function to show our data thus far.####

  sheet_id <- "https://docs.google.com/spreadsheets/d/1l3FpvszyA464lUdF8flhxtJc7L3f6SCgSlVQyn43GrE/edit#gid=0"
  read_sheet(sheet_id) -> cs_data  
  
  output$cs_data_table <-render_gt({
    cs_data %>% 
      gt()
    })
  
####collect responses into a dataframe when pressing submit####
   
  
      
   observeEvent(input$Submit, {
     df <- reactive({
       BMI =  input$BMI
     }
     )}
   )
  
}               
               
               
               
             
  
  




                                   
                                   
                                   
                                  








shinyApp(ui, server)