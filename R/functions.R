CheckFileVariate <-  function(file.name,file.colnames,file.need.colnames) {
  for (i in file.need.colnames) {
    if(!(i %in%file.colnames)) {
      stop(paste("\"",file.name,"\"文件","缺少\"",i,"\"字段",sep=""))
    }
  }
}

CorTestPlus <- function(x) {
  list(x, 
       standard.error = unname(sqrt((1 - x$estimate^2)/x$parameter)))
}

cv <- function(x,na.rm=TRUE) {
  return(sd(x,na.rm=na.rm) / mean(x,na.rm = na.rm))
}


AnalyzeFamilyStructure <-  function(FamilyData) {
  FamilyData <- unique(FamilyData[,c("FamilyID","SireID","DamID")])
  FamilyData_tbl <- tbl_df(FamilyData[,c("FamilyID","SireID","DamID")])
  #全同胞家系的数量
  TotalFullSibFamilyNum <- nrow(FamilyData_tbl)
  #统计与每个父本交配的母本数目
  DamNumperSire <- tally(group_by(FamilyData_tbl, SireID))
  SireNum <- nrow(DamNumperSire)
  #获得父系半同胞家系组
  PaternalHalfSibGroup <- filter(DamNumperSire, n > 1)
  #获得父系半同胞家系组的数量
  PaternalHalfSibGroupNum <- nrow(PaternalHalfSibGroup)
  #获得父系半同胞家系的数量
  PaternalHalfSibFamilyNum <- sum(PaternalHalfSibGroup$n)
  
  #标记父系半同胞家系
  IsHalfSibFamily <- array(FALSE, TotalFullSibFamilyNum)
  FamilyData <- mutate(FamilyData, IsHalfSibFamily)
  FamilyData$IsHalfSibFamily <-
    FamilyData$IsHalfSibFamily |
    (FamilyData$SireID %in% as.character(PaternalHalfSibGroup$SireID))
  
  #统计与每个母本交配的父本数目
  SireNumperDam <- tally(group_by(FamilyData_tbl, DamID))
  DamNum <- nrow(SireNumperDam)
  #获得母系半同胞家系组
  MaternalHalfSibGroup <- filter(SireNumperDam, n > 1)
  #获得母系半同胞家系组的数量
  MaternalHalfSibGroupNum <- nrow(MaternalHalfSibGroup)
  #获得母系半同胞家系的数量
  MaternalHalfSibFamilyNum <- sum(MaternalHalfSibGroup$n)
  #标记母系半同胞家系
  FamilyData$IsHalfSibFamily <-
    FamilyData$IsHalfSibFamily |
    (FamilyData$DamID %in% as.character(MaternalHalfSibGroup$DamID))
  
  #父系和母系半同胞家系合并的数量
  TotalHalfSibFamilyNum <-
    length(FamilyData$FamilyID[FamilyData$IsHalfSibFamily])
  FamilySummary <-
    list(
      SireNum = SireNum,
      DamNum = DamNum,
      TotalFullSibFamilyNum = TotalFullSibFamilyNum,
      PaternalHalfSibGroupNum = PaternalHalfSibGroupNum,
      PaternalHalfSibFamilyNum = PaternalHalfSibFamilyNum,
      MaternalHalfSibGroupNum = MaternalHalfSibGroupNum,
      MaternalHalfSibFamilyNum = MaternalHalfSibFamilyNum,
      TotalHalfSibFamilyNum = TotalHalfSibFamilyNum,
      HalfsibRatio = sprintf("%.2f", TotalHalfSibFamilyNum * 100 / TotalFullSibFamilyNum)
      )
  return(FamilySummary)
}

SummarizeTableTrait <-
  function(trait.data,
           terms,
           terms.names,
           trait.column.name,
           trait.unit = "",
           count.unit = "",
           digit.num = 0,
           title) {
    if (trait.unit == "%") {
      eval(parse(text=paste("trait.data$",trait.column.name," <- trait.data$",trait.column.name," * 100",sep="")))
    }
    trait.data.groups <-
      eval(parse(text = paste(
        "group_by(trait.data,", terms, ")", sep = ""
      ))) 
    trait.data.groups.summ <-
      eval(parse(
        text = paste(
          "summarise(trait.data.groups,T.count=length(",
          trait.column.name,
          "),T.mean = mean(",
          trait.column.name,
          ",na.rm=TRUE),T.min = min(",
          trait.column.name,
          ",na.rm=TRUE),T.max=max(",
          trait.column.name,
          ",na.rm=TRUE),T.sd=sd(",
          trait.column.name,
          ",na.rm=TRUE),T.cv=cv(",
          trait.column.name,
          ")*100)",
          sep = ""
        )
      ))
    
    if (nrow(trait.data.groups.summ) > 1) {
      #汇总数据总体
      trait.data.summ <-
        eval(parse(
          text = paste(
            "summarise(trait.data,T.count=length(",
            trait.column.name,
            "),T.mean = mean(",
            trait.column.name,
            ",na.rm=TRUE),T.min=min(",
            trait.column.name,
            ",na.rm=TRUE),T.max=max(",
            trait.column.name,
            ",na.rm=TRUE),T.sd=sd(",
            trait.column.name,
            ",na.rm=TRUE),T.cv=cv(",
            trait.column.name,
            ")*100)",
            sep = ""
          )
        ))
      trait.data.groups.all.summ <-
        bind_rows(trait.data.groups.summ, trait.data.summ)
    } else {
      trait.data.groups.all.summ <- trait.data.groups.summ
    }
    
    Trait.kable <-
      kable(
        trait.data.groups.all.summ,
        col.names = c(unlist(strsplit(terms.names, ",")), paste("数量/",count.unit,sep=""), paste(c("平均值/", "最小值/", "最大值/", "标准差/"),trait.unit,sep=""), "变异系数/%"),
        digits = digit.num,
        caption = title
      )
    return(list(
      data = trait.data,
      summ = data.frame(trait.data.groups.all.summ),
      table = Trait.kable
    ))
  }

DescStatChinese <- function(vector.desc.stat,scale.unit="",digit.num=2){
  return(paste(
    "平均值为",
    sprintf(paste("%.",digit.num,"f",sep=""),mean(vector.desc.stat,na.rm=TRUE)),scale.unit,
    "，",
    "最小值为",
    sprintf(paste("%.",digit.num,"f",sep=""),min(vector.desc.stat,na.rm=TRUE)),scale.unit,
    "，",
    "最大值为",
    sprintf(paste("%.",digit.num,"f",sep=""),max(vector.desc.stat,na.rm=TRUE)),scale.unit,
    "，",
    "标准差为",
    sprintf(paste("%.",digit.num,"f",sep=""),sd(vector.desc.stat,na.rm=TRUE)),scale.unit,
    "，",
    "变异系数为",
    sprintf(paste("%.",digit.num,"f",sep=""),cv(vector.desc.stat)*100),
    " %",
    sep = ""
  )
)

}  

# 生成类似facet_wrap( ~ Generation + SexID) 形式
ParseFacetTerms <- function(nested.terms = "",scales.value="fixed"){
return(eval(parse(text=paste("facet_wrap(~",paste(unlist(strsplit(nested.terms,split = ",")),collapse = "+"),",scales=\"",scales.value,"\"",")",sep=""))))
}