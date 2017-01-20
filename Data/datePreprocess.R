locs <- read.csv("Data/Galliformes.csv", stringsAsFactors = FALSE)
ord  <- read.csv("Data/Galliformes63.csv", stringsAsFactors = FALSE) 
DAT <- merge(locs, ord[, c("name_c", "family_c", "genus_c")], all.x = TRUE)

save(DAT, file = "Data/DAT.RData")
