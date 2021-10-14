source("csv_converter.R")

date <- c("202012", paste0("20210", 1:9))
common_url <- "https://www.bankofengland.co.uk/-/media/boe/files/prudential-regulation/solvency-ii/"
url <- paste0(common_url, 
        c("risk-free-curves-31-december-2020.xlsx",
         "risk-free-curves-31-january-2021.xlsx",
         "risk-free-curves-28-february-2021.xlsx",
         "risk-free-curves-31-march-2021.xlsx",
         "risk-free-curves-30-april-2021.xlsx",
         "risk-free-curves-31-may-2021.xlsx",
         "risk-free-curves-30-june-2021.xlsx",
         "risk-free-curves-31-july-2021.xlsx",
         "risk-free-curves-31-aug-2021.xlsx",
         "risk-free-curves-30-sept-2021.xlsx"))

map2(date, url, csv_converter)
