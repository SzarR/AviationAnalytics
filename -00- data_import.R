## Project: Exploration of Aviation Analytics Data.
## Purpose: Importing appropriate dataset.
## Created By:  RWS
## Created Date:  4-26-2019

# Global Package Declarations. --------------------------------------------

library(readxl)
library(tidyverse)

# Import ICAO Aircraft Engine Emissions Databank --------------------------

databank <- readxl::read_xlsx(path = file.path("C:\\Users\\rszarek\\Desktop\\R_ROOT\\",
                                               "AviationAnalytics\\input\\",
                                               "edb-emissions-databank v25a (web).xlsx",
                                               fsep = ""),sheet = "ICAO databank",skip = 1)

# Dimensions: 631 rows by 105 columns.

# Extract relevant columns using dplyr.

databank <- databank %>%
  select(No, Identification, Type, Ratio, Ratio__1, Output, Manufacturer ) %>%
  rename(Number = No, ID = Identification, BP_Ratio = Ratio,
         Press_Ratio = Ratio__1, Rated_Output = Output)

# Coerce character columns into numeric.



# Remove rows where every column is NA.

databank <- databank[rowSums(is.na(databank)) != ncol(databank), ]

# Remove rows where 5 out of 6 columns are NA.
# This stands for the manufacturer row.

databank$clean <- rowSums(is.na(databank))

databank <- databank %>%
  filter(clean < 5)

# Remove clean variable from databank

databank <- databank %>%
  select(-clean)

#Clean the rest of the rows where all NAs.

databank <- databank[rowSums(is.na(databank)) != ncol(databank), ]

#Manufacturers. Let's clean up redundant names

databank %>% count(Manufacturer)

#Merge GE

databank$Manufacturer <- ifelse(databank$Manufacturer == "GE Aircraft Engines",
                                "GE",databank$Manufacturer)

#Merge Pratt & Whitney

databank$Manufacturer <- ifelse(databank$Manufacturer == "Pratt & Whitney (Canada)",
                                "Pratt & Whitney",databank$Manufacturer)

databank$Manufacturer <- ifelse(databank$Manufacturer == "Pratt & Whitney Canada",
                                "Pratt & Whitney",databank$Manufacturer)

databank$Manufacturer <- ifelse(databank$Manufacturer == "Pratt and Whitney",
                                "Pratt & Whitney",databank$Manufacturer)

databank %>% count(Manufacturer)

#Merge Rolls Roytce

databank$Manufacturer <- ifelse(databank$Manufacturer == "Rolls-Royce Deutschland",
                                "Rolls Royce",databank$Manufacturer)

databank$Manufacturer <- ifelse(databank$Manufacturer == "Rolls-Royce Corporation",
                                "Rolls Royce",databank$Manufacturer)

databank$Manufacturer <- ifelse(databank$Manufacturer == "Rolls Royce plc",
                                "Rolls Royce",databank$Manufacturer)

# Looks much better.

databank %>% count(Manufacturer)

# Round digits.

databank <- databank %>%
  mutate_at(4:6, round, 2)






