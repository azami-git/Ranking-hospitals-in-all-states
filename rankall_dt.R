rankall <- function(outcome, num = "best") {
  library(data.table)
  
  # Read outcome data
  out_dt <- fread('outcome-of-care-measures.csv')
  
  outcome <- tolower(outcome)
  
  if (!outcome %in% c("heart attack", "heart failure", "pneumonia")) {
    stop('invalid outcome')
  }
  
  # Renaming Columns
  setnames(out_dt,
           tolower(sapply(colnames(out_dt), gsub,
                          pattern = "^Hospital 30-Day Death \\(Mortality\\) Rates from ",
                          replacement = "")))
  
  # Columns indices to keep
  col_indices <- grep(paste0("hospital name|state|^", outcome), colnames(out_dt))
  
  # Keep only relevant columns
  out_dt <- out_dt[, .SD, .SDcols = col_indices]
  
  # Convert outcome to numeric
  out_dt[, outcome] <- as.numeric(out_dt[[outcome]])
  
  if (num == "best") {
    return(out_dt[order(state, get(outcome), `hospital name`)
                  , .(hospital = head(`hospital name`, 1))
                  , by = state])
  }
  
  if (num == "worst") {
    return(out_dt[order(get(outcome), `hospital name`)
                  , .(hospital = tail(`hospital name`, 1))
                  , by = state])
  }
  
  return(out_dt[order(state, get(outcome), `hospital name`)
                , head(.SD, num)
                , by = state, .SDcols = c("hospital name")])
}
