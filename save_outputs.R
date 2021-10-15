source("csv_converter.R")
library(lubridate)
library(stringr)
library(RCurl)

url_base <- "https://www.bankofengland.co.uk/-/media/boe/files/prudential-regulation/solvency-ii/risk-free-curves-"

today <- as_date(now())
month_end <- ceiling_date(today - months(1), "month") - days(1)

month_labels_long <- str_to_lower(month.name)
month_labels_short <- c("jan", "feb", "mar", "apr", "may", "june", "july", "aug", "sept", "oct", "nov", "dec")

url_date <- paste0(day(month_end), "-", month_labels_long[month(month_end)], "-", year(month_end), ".xlsx")
url <- paste0(url_base, url_date)

if (!url.exists(url)) {
  url_date <- paste0(day(month_end), "-", month_labels_short[month(month_end)], "-", year(month_end), ".xlsx")
  url <- paste0(url_base, url_date)
} else if (!url.exists(url)) {
  stop("Manually check month name being used by PRA") 
}

date <- paste0(year(month_end), str_pad(month(month_end), 2, "left", pad = "0"))
csv_converter(date, url)

# Only for initial commit:
# date <- c("202012", paste0("20210", 1:9))
# common_url <- "https://www.bankofengland.co.uk/-/media/boe/files/prudential-regulation/solvency-ii/"
# url <- paste0(common_url, 
#         c("risk-free-curves-31-december-2020.xlsx",
#          "risk-free-curves-31-january-2021.xlsx",
#          "risk-free-curves-28-february-2021.xlsx",
#          "risk-free-curves-31-march-2021.xlsx",
#          "risk-free-curves-30-april-2021.xlsx",
#          "risk-free-curves-31-may-2021.xlsx",
#          "risk-free-curves-30-june-2021.xlsx",
#          "risk-free-curves-31-july-2021.xlsx",
#          "risk-free-curves-31-aug-2021.xlsx",
#          "risk-free-curves-30-sept-2021.xlsx"))
# 
# map2(date, url, csv_converter)