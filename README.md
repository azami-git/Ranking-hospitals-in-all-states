# Best Hospital in the State

This repository contains R functions to determine the best or worst hospitals in each U.S. state based on 30-day mortality rates for selected outcomes.  
This work is adapted from the Johns Hopkins "R Programming" Coursera assignments.

## Functions

- **rankall_base.R**  
  A base R implementation of `rankall()` that reads the `outcome-of-care-measures.csv` dataset and returns hospitals by rank.

- **rankall_dt.R**  
  A `data.table` implementation of the same function for efficiency.

## Usage

```r
# Load the base R version
source("rankall_base.R")

# Example: best hospital for heart attack by state
rankall("heart attack", "best")

# Load the data.table version
source("rankall_dt.R")

# Example: 10th ranked hospital for pneumonia by state
rankall("pneumonia", 10)
