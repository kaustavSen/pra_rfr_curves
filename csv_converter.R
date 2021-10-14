library(tidyverse)
library(readxl)

csv_converter <- function(date, url) {
  
  tf <- tempfile(fileext = ".xlsx")
  curl::curl_download(url, tf)
  
  cols <-
    read_excel(
      path = tf,
      sheet = "RFR_spot_no_VA",
      range = "C2:BC2",
      col_names = FALSE
    ) %>% 
    pivot_longer(cols = everything()) %>% 
    replace_na(list(value = "empty")) %>% 
    rownames_to_column() %>% 
    mutate(value = if_else(value == "empty", paste0(value, "_", rowname), value)) %>% 
    pull(value)
  
  rfr_base_no_VA <- read_excel(
    path = tf,
    sheet = "RFR_spot_no_VA",
    range = "B11:BC160",
    col_names = FALSE
  )
  
  rfr_base_with_VA <- read_excel(
    path = tf,
    sheet = "RFR_spot_with_VA",
    range = "B11:BC160",
    col_names = FALSE
  )
  
  colnames(rfr_base_no_VA) <- c("year", cols)
  colnames(rfr_base_with_VA) <- c("year", cols)
  
  unlink(tf)
  
  rfr_base_no_VA <- rfr_base_no_VA %>% 
    select(-starts_with("empty")) %>% 
    pivot_longer(-year, values_to = "rate", names_to = "country")
  
  write_csv(rfr_base_no_VA, paste0("outputs/", date, "_no_VA.csv"))
  
  rfr_base_with_VA <- rfr_base_with_VA %>% 
    select(-starts_with("empty")) %>% 
    pivot_longer(-year, values_to = "rate", names_to = "country")
  
  write_csv(rfr_base_with_VA, paste0("outputs/", date, "_with_VA.csv"))  
}