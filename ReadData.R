# Reading Multiple Files ----
library(tidyverse)
library(fs)
library(readxl)

file_paths <- fs::dir_ls("//192.168.2.80/Trading/0. DATA/EEX_SFTP_DATA")
file_paths

paths_minus_eua <- file_paths[2:5]

# For Loop for Yearly products ----

file_contents_minus_eua <- list()

for (i in seq_along(paths_minus_eua)) {
  file_contents_minus_eua[[i]] <- readxl::read_xlsx(
    path = paths_minus_eua[[i]], sheet = 8
  )
}

file_contents_minus_eua <- set_names(file_contents_minus_eua, paths_minus_eua)

#eua <- file_contents[[1]]
fr_BY <- file_contents_minus_eua[[1]]
hu_BY <- file_contents_minus_eua[[2]]
it_BY <- file_contents_minus_eua[[3]]
de_BY <- file_contents_minus_eua[[4]]


 # Data Manipulation ----


colnames(de_BY) <- as.character(de_BY[2, ])
de_BY <- de_BY[-c(1,2),]

de_BY <- de_BY %>% select(c(1,3,7,8,10,12,16))
de_BY %>% rename("Trading_Day" = "Trading Day", "Settlement_Price" = "Settlement Price",
                 "Open_Price" = "Open Price", "High_Price" = "High Price", "Low_Price")




