#-------------1.检查家系数据结构文件---------------------------------
families <-
  read.csv(FamilyInfo, head = TRUE, stringsAsFactors = FALSE)
families.colnames <- colnames(families)
families.need.colnames <-
  c("Generation",
    "SireID",
    "DamID",
    "FamilyClass",
    "Birthday")

CheckFileVariate(
  file.name = family.file.name,
  file.colnames = families.colnames,
  file.need.colnames = families.need.colnames
)
families$SireID <- as.character(families$SireID)
families$DamID <- as.character(families$DamID)

#-------------end-----------------------------------------------------

#-------------2.检查系谱文件------------------------------------------

pedigree <-
  read.csv(file = pedigree.file.name.path,
           header = TRUE,
           stringsAsFactors = FALSE)
pedigree.colnames <- colnames(pedigree)
pedigree.need.colnames <-
  c("AnimalID",
    "SireID",
    "DamID",
    "FamilyID",
    "SexID",
    "Year",
    "Breed")
CheckFileVariate(
  file.name = pedigree.file.name,
  file.colnames = pedigree.colnames,
  file.need.colnames = pedigree.need.colnames
)
#修改列表头跟optiSel要求一致
pedigree.colnames[pedigree.colnames %in% c("SexID")] <- "Sex"
pedigree.colnames[pedigree.colnames %in% c("Year")] <- "Born"
colnames(pedigree) <- pedigree.colnames
pedigree$Sex[pedigree$Sex %in% c("Male")] <- 1
pedigree$Sex[pedigree$Sex %in% c("Female")] <- 2
#-------------end-----------------------------------------------------
