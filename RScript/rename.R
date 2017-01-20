FF <- list.files("www/img", full.names=TRUE)
ff <- gsub(".jpg", "", list.files("www/img", full.names=FALSE))
NM <- unique(DAT[, c("name_c", "name_e")])
NM$name_e <- gsub("[[:punct:]]| ", "", NM$name_e)

file.rename(paste("www/img/", NM$name_c, ".jpg", sep = ""),
            paste("www/img/", NM$name_e, ".jpg", sep = ""))
