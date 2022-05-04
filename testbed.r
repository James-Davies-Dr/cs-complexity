library(shiny)
library(shinydashboard)
library(tidyverse)
library(googlesheets4)
library(lubridate)
library(gt)



sheet_id <- "https://docs.google.com/spreadsheets/d/1l3FpvszyA464lUdF8flhxtJc7L3f6SCgSlVQyn43GrE/edit#gid=0"
read_sheet(sheet_id) -> cs_data


cs_data %>% gt()

test_upload <- data.frame(
  LogbookID = 1,
  PatientId = "k123456",
  Date = "03/05/22",
  Indication = "distress",
  BMI = 40,
  PreviousCS = "no",
  PreviousSurgery = "no",
  Placenta = "high anterior",
  Lie = "longitudinal",
  Presentation = "cephalic",
  Multiple = "no",
  Gestation = "40",
  FullDilatation = "no",
  LowerSegmentFibroids = "no",
  BloodLoss = 350)
  
  
  
sheet_append(sheet_id, test_upload, sheet = 1)

##ok so this bit works.
##next is creating the shiny thing that gets those answers from the shiny inputs; plus  a box to clear the inputs, and box to append, lets make an easier one to start with.




