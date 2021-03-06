# Load packages
library(RSelenium)
library(purrr)
library(tidyverse)
library(magrittr)

map2(.x = list.files("data/raw_rki/zip") %>% 
       (function(x){
          ord <- x %>% gsub('\\D+','', .) %>% as.numeric() %>% order()
          ordered <- x[ord]
          return(ordered)
        }),
     .y = voteR::laender %>% pull(id) %>% as.character() ,
     .f = function(a,b){
       unzip(zipfile = paste0("data/raw_rki/zip/",a),
                  exdir = paste0("data/raw_rki/unzipped/",b))
       })


dfs <- 
  map2(.x = list.files(path = "data/raw_rki/unzipped/",
                    pattern = "\\.csv$",
                    recursive = T),
       .y = voteR::laender %>% pull(id) %>% as.character() %>% .[c(1:12,14,13,15:16)],
      .f = ~ read.delim(file = paste0("data/raw_rki/unzipped/",.x),
                        skip = 1,
                        fileEncoding="UTF-16LE") %>% 
        mutate(land = .y) %>% 
        mutate_if(is.factor,funs(as.character(.))))


dfs_cleaned <- 
  map(dfs,
      .f = ~ 
        .x %>% 
        gather(key,value,-X,-land) %>% 
        rename(region = X) %>% 
        mutate(year = key %>% stringr::str_sub(.,2,5),
               week = key %>% stringr::str_sub(.,9,10)) %>% 
        mutate(yw = paste0(year,"-",week)) %>% 
        mutate(mondayDate = as.Date(paste0(yw,"-1"), '%Y-%W-%u'))
      )

binded <- 
  dfs_cleaned %>% 
  bind_rows %>% 
  mutate(land = land %>% str_replace_all("baden-wuettemberg","baden-wuerttemberg"))

write.csv2(binded,"data/df_all_laender.csv")
rm(binded)
