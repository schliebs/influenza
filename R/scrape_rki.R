# Set up Docker and TightVNC-Viewer

# http://ropensci.github.io/RSelenium/articles/docker.html
# docker pull selenium/standalone-firefox-debug:2.53.0
# docker run -d -p 4445:4444 -p 5901:5900 selenium/standalone-firefox-debug:2.53.0
# docker-machine ip
# docker ps --format 'table {{.Names}}\t{{.Image}}\t{{.ID}}'

# Start scraping

# Load packages
library(RSelenium)
library(purrr)
library(dplyr)
library(magrittr)


human_wait = function(t = 2, tt = 4){
  Sys.sleep(sample(seq(t, tt, by=0.001), 1)) 
}


map(5:6,
    .f = function(x){

rd = rsDriver()
remDr2 = rd[["client"]]  

# remDr2 <- remoteDriver(
#   remoteServerAddr = "192.168.99.100",
#   extraCapabilities = ePrefs,
#   port = 4445L
# )


remDr2$navigate("https://survstat.rki.de/Content/Query/Create.aspx")
remDr2$getTitle()

human_wait()

remDr2$findElement(using = "xpath",
                   value = '//*[@id="ContentPlaceHolderMain_ContentPlaceHolderAltGridFull_RepeaterFilter_ImageButtonDeleteFilterRow_0"]')$clickElement()

human_wait(1,2)

remDr2$findElement(using = "xpath",
                    value = '/html/body/form[1]/div[3]/div[1]/div[2]/div/div[2]/div/div/div[2]/table/tbody/tr[2]/td[2]/div/a/span')$clickElement()

human_wait(1,2)

remDr2$findElement(using = "xpath",
                  value = '/html/body/form[1]/div[3]/div[1]/div[2]/div/div[2]/div/div/div[2]/table/tbody/tr[2]/td[2]/div/div/ul/li[15]')$clickElement()

human_wait(1,2)

# filter BL
remDr2$findElement(using = "xpath",
                    value = '/html/body/form[1]/div[3]/div[1]/div[2]/div/div[2]/div/div/div[2]/table/tbody/tr[3]/td[2]/table/tbody/tr[1]/td[3]/div/ul')$clickElement()

human_wait(1,2)

# filter BL
remDr2$findElement(using = "xpath",
                   value = paste0('//*[@id="ContentPlaceHolderMain_ContentPlaceHolderAltGridFull_RepeaterFilter_RepeaterFilterLevel_0_ListBoxFilterLevelMembers_0_chosen"]/div/ul/li[',x,']'))$clickElement()

human_wait()

remDr2$findElement(using = "xpath",
                   value = paste0('//*[@id="ContentPlaceHolderMain_ContentPlaceHolderAltGridFull_DropDownListRowHierarchy_chosen"]/a/span'))$clickElement()

human_wait()

#select rows
remDr2$findElement(using = "xpath",
                  value = '//*[@id="ContentPlaceHolderMain_ContentPlaceHolderAltGridFull_DropDownListRowHierarchy_chosen"]/div/ul/li[15]')$clickElement()

human_wait(1,2)

#select rows
remDr2$findElement(using = "xpath",
                   value = '//*[@id="ContentPlaceHolderMain_ContentPlaceHolderAltGridFull_DropDownListRow_chosen"]/a/span')$clickElement()

human_wait(1,2)
#select rows
remDr2$findElement(using = "xpath",
                   value = '//*[@id="ContentPlaceHolderMain_ContentPlaceHolderAltGridFull_DropDownListRow_chosen"]/div/ul/li[4]')$clickElement()

human_wait()

# cols
remDr2$findElement(using = "xpath",
                   value = '//*[@id="ContentPlaceHolderMain_ContentPlaceHolderAltGridFull_DropDownListColHierarchy_chosen"]/a/span')$clickElement()

human_wait()

remDr2$findElement(using = "xpath",
                    value = '//*[@id="ContentPlaceHolderMain_ContentPlaceHolderAltGridFull_DropDownListColHierarchy_chosen"]/div/ul/li[7]')$clickElement()

human_wait()

remDr2$findElement(using = "xpath",
                  value = '//*[@id="ContentPlaceHolderMain_ContentPlaceHolderAltGridFull_CheckBoxNonEmpty"]')$clickElement()

human_wait()

remDr2$findElement(using = "xpath",
                  value = '//*[@id="ContentPlaceHolderMain_ContentPlaceHolderAltGridFull_ButtonDownload"]')$clickElement()

human_wait()

remDr2$close()

})

