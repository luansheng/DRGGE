#---------------------DRGGE参数文件附加说明------------------
# 1.Mainutf8.Rmd文档中的五级标题和六级标题的功能另作它用：
#   其中#####五级标题在生成的docx中用做分页符；######六级标题在生成的docx中用作图的标题样式；
#   这两个功能通过在模板文件Style/mystyles.docx中设定样式来完成。
# 2.生成报告所需要的数据文件请放置在Data文件夹下。
# 3.灵活配置与生成报告的内容。
#   利用嵌套分析语法，书写形式为c("term1, term2")。譬如c("Generation, FamilyClass")，
#   表示针对不同世代、不同家系类型组合的子数据集进行分析。
#   如果Generation有2个世代，FamilyClass有3种类型，那么就会对3*2=6个子数据集分别进行分析。
#   如果有多个性状，譬如两个性状，写为c("Generation, FamilyClass", "Generation, FamilyClass")这种形式。
#   表示对每个性状，都针对子数据集进行分析。
# 4.本系统在实际使用过程，可以灵活使用。
#   譬如：可以针对整体数据如c("Generatioin")，生成一个基础遗传评估报告;
#   然后再针对不同的组合条件，如c("Generation,FamilyClass")，生成需要的图和表，
#   插入或替换基础遗传评估报告中的表格和图。
#----------------end-------------------------------------------

#----------------基础参数--------------------------------------
# 委托评估单位
company.name = "江苏数丰水产种业有限公司"

# 执行遗传评估的相关人员，包括家系构建、数据整理和遗传分析等人员。
authors = "栾生、夏正龙、隋娟、孔杰、杨国梁"

# 待评估物种的中文名称
species.chinese.name = "罗氏沼虾"

# 待评估物种的英文名称
species.english.name = "Giant freshwater prawn"

# 待评估物种的拉丁学名
species.latin.name = "Macrobrachium rosenbergii"

# *待评估的当前世代。Todo: 下一步应该考虑，可以针对多世代进行分析。
#譬如2017G8(2011),其中2017表示当前世代个体出生的年份；海兴农南美白比较特殊，基础群体从G1开始编号，其中G8表示从G1开始，已经完成了7次选择，括号中的2011表示G1世代开始的年份。
generation.name = "2018G02" 

# 遗传评估报告编号
# 规则：
#     两位单位缩写；两位物种的拉丁学名缩写；第1个家系出生日期，YYYYMMDD形式
#     SFMR20160406表示：SF-江苏数丰水产种业有限公司；MR-罗氏沼虾拉丁学名Macrobrachium rosenbergii；
#     20160406-第一个家系孵化日期
report.No = "SFMR20180325"  
#----------------end-------------------------------------------






#----------------1.家系建立和测试过程分析---------------
# 家系信息文件名称，该文件必须要放在Data文件夹下,该文件是csv文件，用英文逗号,分割
family.file.name <- "SFMR2018G02FamilyInfo.csv"

# 家系文件列表头（文件中第1行），必须要包括以下字段,-后是相应的解释:
#     Generation-世代
#     FamilyID-家系编号
#     SireID-父本编号
#     DamID-母本编号
#     FamilyClass-家系类型
#     Birthday-出生日期

# 是否分析家系数据结构，主要是有多少个半同胞，多少个全同胞等信息
is.family.structure = TRUE
# 会生成一个家系结构表，第一列是要统计的家系结构参数，从第二列开始，是不同的家系类型。
# 因此FamilyClass这个字段必须要有
# 注意这个表中不能够对不同的世代进行分析，仅能分析当前世代。
#----------------------------------------------------------------
# 家系类型     	      NP	 NP/T1G00	T1G00/NP	T1G01	T2G00	全部
# 父本数	            54	   9	      11	      7	   9  	90
# 母本数	            81	   12	      11      	7	   9	  120
# 全同胞家系数	      81  	 12	      11	      7	   9	  120
# 父系半同胞组数    	24    	3     	0	        0	   0	  27
# 父系半同胞家系数	  51	    6	      0	        0	   0  	57
# 母系半同胞组数	    0	      0	      0	        0	   0  	0
# 母系半同胞家系数  	0	      0	      0	        0	   0	  0
# 半同胞家系数	      51	    6	      0	        0	   0	  57
# 半同胞家系比率（%）	62.96	50.00	  0.00     	0.00	0.00	47.50
#----------------------------------------------------------------

#是否分析家系生产的同步性
is.family.standardization = TRUE 

# 生成家系生产日期分布柱状图，定义其分析数据集
# 生成家系生产同步性表格，主要是包括每个标准化阶段的持续天数。
# 柱状图的横坐标是日期，因此在嵌套term中，可以嵌入世代。
family.birthday.barplot.nested.term = c("Generation")

# 标准化次数（包括打标记，作为最后一次标准化），通过standardization.num变量定义。
standardization.num <- 3 
# 如果standardization.num <- 3 ,表示包括2次家系标准化和1次VIE家系标记；
# 注意，标准化次数最小必须为2。

# 此处定义每个标准化阶段在图表中对应的中文名称。
# standardization.num <- 3，表示有2次标准化，1次VIE标记，那么standardization.label应该有3个元素
standardization.label <-  c("孵化","仔虾","VIE标记") #注意"和,必须是英文字符

# 如上所叙述，以虾为例，如果定义了standardization.num = 4次，那么家系信息文件中需要包括以下字段：
# 前三次标准化日期字段：S1Date、S2Date、S3Date；
# 第四次标准化是打标记日期字段：S4Date；
# S4BW：每个家系标记时家系平均体重或者个体体重或体长等

#文档中生成一个核心育种群体家系不同标准化阶段天数汇总表
#-------------------------------------------------------------
# 不同阶段	                     平均值/d	最小值/d	最大值/d  
# 孵化阶段到仔虾阶段天数	       21.76	    18	      26
# 仔虾阶段到VIE标记阶段天数	     55.83	    42	      67
# 孵化阶段到VIE标记阶段天数	     75.58	    60	      85
#-------------------------------------------------------------


##############begin是否对标准化阶段的存活率进行箱型图Boxplot分析##############
is.family.standardization.survival <- TRUE

# 对哪几个标准化阶段的存活率进行箱型图Boxplot分析。
# 如果standardization.num <- 3 ,最多可以对3个阶段的存活率进行分析。
# 如果standardization.survial.analysis <- c(TRUE,TRUE,TRUE),那么表示要对
# S1-S2，S2-S3，S1-S3这三个阶段的存活率进行统计分析。
# 那么家系信息文件中还需要包括
# S1StockNum-表示第1次标准化数量，S1SurNum-表示S1-S2期间养殖存活个体数，
# S2StockNum-表示第2次标准化数量，S2SurNum-表示S2-S3期间养殖存活个体数等字段，以用于计算每个标准化阶段存活率；
standardization.survial.analysis <- c(TRUE,TRUE,FALSE) 

# Boxplot图的横坐标label
standardization.survial.analysis.label <- c("孵化到仔虾阶段","仔虾到VIE标记阶段","") 

# Boxplot图的嵌套分析层次
# 箱线图，需要有个横坐标，因此在term中用Generation来表示
# 由于存活率本身就是以家系为单位，所以term中不需要包括FamilyID。
standardization.survial.boxplot.nested.term = c("Generation") 
##############end##############



# 是否执行标记时体重或体长等性状分析
# 绘制2个图：
# 1.标记时性状与标记时日龄的散点图 默认的term嵌套层次Generation
# 2. 家系标记时体重的散点图 默认的term嵌套层次Generation
# 必须要有标准化日期S1Date（日龄基于S1Date计算），才可以执行此项分析。
# 不然无法执行标记日龄和标记时性状的相关，也无法画出散点图。
is.tagging.trait.analysis <-  TRUE  

# 标记时测定性状的名称，用于说明或者坐标文本用
tagging.trait.label <- "标记时体重" 

# 标记时测定性状在family.file.Name文件中的列表头名称
tagging.trait.column.name <- "S3BW"  

# 标记时测定性状的单位
tagging.trait.unit <- "g"

# 生成标记时性状跟日龄的相关性散点图，此处定义分析的数据集
tagging.trait.age.scatter.nested.term = c("Generation") 

#----------------end-----------------------------------------







#----------------2.育种群体的系谱分析------------------------
# 是否执行系谱分析。如果为否，第二部分中的变量可以不用定义。
is.pedigree.analysis = TRUE

# 系谱文件包括6列，前3列名称为：AnimalID, SireID, DamID，
# 后4列必须为FamilyID, SexID, Year, Breed，
# 需要说明，这里的系谱是一个prune后的系谱。
# 各字段的特别说明：
#     SexID-性别，其中male为雄，female为雌；
#     Year-个体的出生年份，用2006,2007等表示;
#     Breed-奠基者个体所属的群体或者说血统,要分析的当前世代Breed设置为unknown

# 系谱文件名称
pedigree.file.name = "SFMR2018G02NoRePed.csv"

# 指定奠基者群体中，某个群体作为本地群体，这里指SIS群体。
native.breed = "MP" 

# 设定世代，计算其个体间的亲缘系数。设置为2018，实际上是2017年出生的
keep.kin.year <- "2018"

# 在计算PCI指数，可以通过pedigree.depth参数指定往回追溯的系谱深度。
# 可追溯世代影响PCI计算的结果，一般可以往回追溯至奠基者群体几个世代，就写几个。
# 譬如G0群体，到奠基者群体，只可以往回追溯1个世代。
pedigree.depth <- 3
#----------------end------------------------------------------






#----------------3.目标性状的描述性统计分析(summTrait.Rmd)-------------------
# 定义分析性状的各种属性

# 性状所在数据文件列名字
trait.column.name = c("M2BW", "ADG", "SurRate") 

# 性状的中文名称，在文本描述，图表标题和坐标轴标题会用到。
# 譬如只分析体重性状，那么就应该写作 trait.chinese.label = c("体重")
trait.chinese.label = c("收获体重", "日增重", "存活")

# 性状的英文名称，在文本描述，图表标题和坐标轴标题可能会用到，暂时没有用到
# trait.english = c("Harvest body weight", "Harvest body length")

# 性状的缩写，在文本描述，图表标题和坐标轴标题时用到,这个变量必须定义
# 譬如只分析WT性状，那么就应该写作 trait.abb = c("WT")
trait.abb = c("WT", "ADG", "SUR")

# 性状的计量单位，在文本描述，图表标题和坐标轴标题时用到
# 用法同上
trait.unit <- c("g", "g/d", "%")

# 性状的性质，CON:连续性状，THR:阈值性状，目前没有用到
# 用法同上
# trait.class = c("CON", "THR") 


# 定义数据分析的层次
# 个体水平上的嵌套层次
# trait.individ.nested.term = c("SexID", "TankID")表示：
#     对于M2BW收获体重，对性别（雌雄）2个数据集分析；
#     对于SurRatio存活性状，对测试池（多个）数据集分析；
# 如果要对每个性状，基于不同条件组合的数据集执行分析，可以写作形如
# trait.individ.nested.term = c("Generation,SexID", "Generation,TankID") 
#trait.individ.nested.term = c("Generation, FamilyClass", "Generation,FamilyClass") 

# 不同组合的文字名称
#trait.individ.nested.term.label = c("世代, 家系类别", "世代, 家系类别") #其中的逗号为英文逗号

#家系水平上的嵌套层次,同上
#trait.family.nested.term = c("Generation, FamilyClass", "Generation, FamilyClass")
#trait.family.nested.term.label = c("世代, 家系类别", "世代, 家系类别") #其中的逗号为英文逗号


##############begin sub##########################
# 是否开展基于个体水平的描述统计分析
# 包括描述性统计参数表、箱线图
is.individ.stats = c(TRUE, TRUE, FALSE) 

# 性状对应的个体数据文件名称,也包括个体目标性状的观测值和育种值
# 用法：对1个性状进行个体分析，trait.individ.filename = c("MR2016G0(2016)IndivData.csv","")
#       对2个性状进行个体分析，trait.individ.filename = c("MR2016G0(2016)IndivData.csv","MR2016G0(2016)IndivData.csv") 
trait.individ.filename = c("SFMR2018G02GrowthSurSelIndexG02.csv", "SFMR2018G02GrowthSurSelIndexG02.csv", "HXLV2017GrowthSurSelIndexG8.csv", "") 

#个体水平上性状的描述性统计参数，单世代加入Generation意义不大。
# 性状个体水平上嵌套分析层次，用于表型值、育种值和选择指数等分析
# 用法：譬如对第1个性状，基于TankID与SexID组合的数据集进行分析；
# trait.individ.nested.term = c("TankID,SexID", "") ，注意term间用英文","分割。
tsd.table.trait.individ.nested.term = c("EnvLabel, SexID", "EnvLabel, SexID", "EnvLabel") 

# term对应的解释，用于文本、图表描述
tsd.table.trait.individ.nested.term.label = c("养殖模式, 性别", "养殖模式, 性别", "养殖模式") #其中的逗号为英文逗号,中间不要有空格

# 个体水平上性状的箱线图分析
# 由于箱线图Generation是做X轴，如果是Generation*FamilyClass, 就会是类似于2017G01(2016).NP
# 2017G01(2016).T1G01类似形式，所以嵌套进Generation不像散点图，在顶端，因此嵌套进Generation意义不大。
# 嵌套分组层次默认同trait.individ.nested.term，否可以自行设定
tsd.boxplot.trait.individ.nested.term = c("EnvLabel, SexID", "EnvLabel, SexID", "EnvLabel") 
tsd.boxplot.trait.individ.nested.term.label = c("养殖模式, 性别", "养殖模式, 性别", "养殖模式")
##############end sub##########################

############begin sub############################
# 是否开展基于家系水平的描述统计分析##
is.family.stats = c(TRUE, TRUE, TRUE) 

# 性状对应的家系数据文件名称,也可以包括家系目标性状的观测值和育种值
trait.family.filename = c("SFMR2018G02FamilySummaryperGenerationEnvTankIDG02.csv", "SFMR2018G02FamilySummaryperGenerationEnvTankIDG02.csv", "SFMR2018G02FamilySummaryperGenerationEnvTankIDG02.csv")

# 家系水平上性状的描述性统计参数表格，单世代加入Generation意义不大。
# 嵌套分组层次
# 譬如tsd.table.trait.family.nested.term = c("TankID, SexID", "FamilyClass") 
#对于第一个性状，嵌套层次是TankID下嵌套SexID
tsd.table.trait.family.nested.term = c("EnvLabel, TankID", "EnvLabel, TankID", "EnvLabel, TankID") 
# term对应的解释，用于文本和图表描述
tsd.table.trait.family.nested.term.label = c("养殖模式, 测试池", "养殖模式, 测试池", "养殖模式, 测试池") #其中的逗号为英文逗号,中间不要有空格

# 家系水平上性状的箱线图分析
# 由于箱线图Generation是做X轴，如果是Generation*FamilyClass, 就会是类似于2017G01(2016).NP
# 2017G01(2016).T1G01类似形式，所以嵌套进Generation不像散点图，在顶端，因此嵌套进Generation意义不大。
tsd.boxplot.trait.family.nested.term = c("EnvLabel, TankID", "EnvLabel, TankID", "EnvLabel, TankID")
tsd.boxplot.trait.family.nested.term.label = c("养殖模式, 测试池", "养殖模式, 测试池", "养殖模式, 测试池")


# 家系水平的协变量分析，育种目标性状与协变量的散点图
is.covariate.analysis = c(TRUE, TRUE, TRUE)

# 数据文件中协变量的列表头名称
covariate.col.name = c("M1BW","M1BW", "M1BW")
covariate.label = c("标记时体重","标记时体重", "标记时体重")

# 家系水平上的协变量与目标性状的散点图分析
# 嵌套层次同trait.family.nested.term
tsd.covariate.trait.family.nested.term = c("Generation", "Generation", "Generation")
############end sub############################

# 测试个体计量单位，鱼虾-尾，贝-个
individ.unit <- "尾"

# 测试家系的计量单位
family.unit <- "个"

# 报告中小数点后数值的显示位数
digit.num <- 2
#----------------end------------------------------






#--------------------4.育种群体目标性状的遗传参数估计------------
# 是否展示每个性状的遗传参数估计模型
is.genetic.model = c(TRUE, FALSE, TRUE)

# 定义每个性状的遗传评估模型方程,Latex格式书写。
# 可以通过一个在线编辑器来生成相应的Latex代码。http://www.codecogs.com/latex/eqneditor.php?lang=zh-cn
# 为了在输出报告中正确的显示latex代码生成的公式，Latex代码块前后用$$包围。\\是为了输出第二个反斜杠backslash
trait.models <-
  c(
    "$$y_{ijklmn}=\\mu+Gen_{i}+Sex_{j}+Sex_{j}*SS_{k}+Gen_{i}*Sex_{j}*SS_{k}+Gen_{i}*Tank_{l}+Gen_{i}*Sex_{j}*SS_{k}*Tank_{l}+Age_{m}(Gen_{i}*Sex_{j}*SS_{k}*Tank_{l})+a_{m}+c_{n}+e_{ijklmn}$$",
    "",
    "$$Pr(y_{ilmnoq}=1)=Pr(\\eta_{ilmnoq}>0)=\\Phi(\\mu+Gen_{i}+Tank_{l}+Gen_{i}*Tank_{l}+s_{o}+d_{q}+c_{n})$$"
  )

# 定义每个性状遗传参数估计模型中符号的相应说明
trait.models.description <-
  c(
    paste(
      "其中$y_{ijklmn}$表示第m",
      individ.unit,
      "个体的",
      trait.chinese.label[1],
      "，$\\mu$表示总体均值",
      "，$Gen_{i}$表示第i个世代(G00、G01)固定效应",
      "，$Sex_{j}$表示第j个性别（雌、雄）固定效应",
      "，$Sex_{j}*SS_{k}$表示第j个性别与第k个性别特征（雌虾：是否抱卵；雄虾：有无大鳌）交互的固定效应",
      "，$Gen_{i}*Sex_{j}*SS_{k}$表示第i世代、第j个性别与第k个性别特征（雌虾：是否抱卵；雄虾：有无大鳌）交互的固定效应",
      "，$Gen_{i}*Tank_{l}$表示第i世代与第l个测试池交互的固定效应",
      "，$Gen_{i}*Sex_{j}*SS_{k}*Tank_{l}$表示第i世代、第j个性别、第k个性别特征（雌虾：是否抱卵；雄虾：有无大鳌）与第l个测试池交互的固定效应",
      "，$Age_{m}(Gen_{i}*Tank_{l}*Sex_{j}*SS_{k})$表示嵌套在第i世代、第j个性别、第k个性别特征（雌虾：是否抱卵；雄虾：有无大鳌）与第l个测试池交互固定效应内的第m",
      individ.unit,
      "个体的日龄协变量",
      "，$a_{m}$表示第m",
      individ.unit,
      "个体的",
      "加性遗传效应（随机效应）",
      "，$c_{k}$表示第k",
      family.unit,
      "全同胞家系的",
      "共同环境效应（随机效应）",      
      "，$e_{ijkm}$表示第m",
      individ.unit,
      "个体的",
      "随机残差。",
      sep = ""
    ),
    "",
    paste(
      "其中$y_{ilmnoq}$表示第m",
      individ.unit,
      "个体的存活性能(0:死亡;1:存活)",
      "，$\\eta_{ilmnoq}$表示潜在变量，如果$\\eta_{ilmnoq}$>0那么$y_{ilmnoq}$=1，如果$\\eta_{ilmnoq}$≤0那么$y_{ilmnoq}$=0",
      "，$\\mu$表示总体均值",
      "，$Gen_{i}$表示第i个世代固定效应",      
      "，$Tank_{l}$表示第l个测试池固定效应",
      "，$Gen_{i}*Tank_{l}$表示第i世代与第l个测试池的固定效应",
      "，$s_{o}$表示第o",
      individ.unit,
      "父本的加性遗传效应",
      "，$d_{q}$表示第m",
      individ.unit,
      "母本的加性遗传效应。",
      sep = ""
    )
  )

# 定义每个性状遗传力的计算公式
trait.models.h2.equation <-
  c(
    "$$h^{2}=\\frac{\\sigma _{a}^{2}}{\\sigma _{a}^{2}+\\sigma _{c}^{2}+\\sigma _{e}^{2}}$$",
    "",
    "$$h^{2}=\\frac{4\\sigma _{sd}^{2}}{2\\sigma _{sd}^{2}+\\sigma _{c}^{2}+\\sigma _{e}^{2}}$$"
  )
# 定义每个性状遗传力计算公式中符号的相应描述
trait.models.h2.description <-
  c(
    paste(
      "其中$h^{2}$表示",
      trait.chinese.label[1],
      "性状的遗传力",
      "，$\\sigma _{a}^{2}$表示加性遗传方差",
      "，$\\sigma _{c}^{2}$表示共同环境方差",
      "，$\\sigma _{e}^{2}$表示残差方差。",
      sep = ""
    ),
    "",
    paste(
      "其中$h^{2}$表示",
      trait.chinese.label[2],
      "性状的遗传力",
      "，$\\sigma _{sd}^{2}$表示父母本加性遗传方差均值",
      "，$\\sigma _{c}^{2}$表示共同环境方差",
      "，$\\sigma _{e}^{2}$表示残差方差。",
      sep = ""
    )
  )

# 遗传参数估计结果的展示表格
# rmd文档中表格的样式，这部分非常复杂，生成一个空的表格，后期在Word中自行输入相应的值。
trait.models.h2.table <-
  c(
    paste(
      "性状 | 表型方差$\\sigma_{p}^{2}$  | 加性遗传方差$\\sigma_{a}^{2}$   | 共同环境方差$\\sigma_{c}^{2}$ | 残差方差$\\sigma_{a}^{2}$ | 遗传力$h^{2}$ | 共同环境系数$c^{2}$ |\n",
      "---- | -------------------------- | ------------------------------  | ----------------------------- | ------------------------- | ------------- | ------------------- |\n",
      " WT  |  108.08±1.64               | 22.74±3.78                      | 3.52±0.85                     | 81.82±1.98                |  0.21±0.03    | 0.03±0.01           |\n",  
      sep = ""
    ),
    "",
    paste(
      "性状 | 表型方差$\\sigma_{p}^{2}$  | 加性遗传方差$4\\sigma_{sd}^{2}$ | 共同环境方差$\\sigma_{c}^{2}$ | 残差方差$\\sigma_{a}^{2}$ | 遗传力$h^{2}$ | 转换后遗传力$h_{b}^{2}$ | 共同环境系数$c^{2}$ |\n",
      "---- | -------------------------- | ------------------------------- | ----------------------------- | ------------------------- | ------------- | ---------------------   | ------------------- |\n",
      "SUR  | 1.08±0.01                  | 0.08±0.024                      | 0.04±0.01                     | 1±0.00                    | 0.07±0.02     | 0.04±0.01               | 0.04±0.01           |\n",
      sep = ""
    )
  )

#----------------end------------------------------






#--------------------5.育种群体目标性状的育种值预测------------
# 分析每个目标性状表型值和育种值的相关性，主要是通过相关系数和散点图来表示。分个体和家系两个水平。
# 在家系水平上，展示家系的育种值排序。

# 育种目标性状育种值在文件中的列表头名称
trait.ebv.column.name = c("gAnimalEBV", "","sReSurRate") #T性状所在数据文件列名字

# 是否开展基于个体水平的育种值预测分析, TRUE表示第1个性状开展分析，FALSE表示第2个性状不开展分析
is.ebv.individ = c(TRUE, FALSE, FALSE) 

# 汇总个体水平上育种值的描述性统计参数
# 嵌套分组层次
tep.table.trait.individ.nested.term = c("EnvLabel, SexID","","")
# 每个性状条件组合对应的描述
tep.table.trait.individ.nested.term.label = c("养殖模式, 性别","","")

# 画出个体水平上育种值的箱形图
tep.boxplot.trait.individ.nested.term = c("EnvLabel, SexID","","")
# 每个性状条件组合对应的描述
tep.boxplot.trait.individ.nested.term.label = c("养殖模式, 性别","","")

# 画出个体水平上性状表型值与育种值的散点图
# 嵌套分组层次同trait.individ.nested.term
tep.trait.individ.nested.term = c("EnvLabel, SexID","","")

# 是否开展基于家系水平的育种值预测分析
is.ebv.family = c(TRUE, FALSE, TRUE) 

# 汇总家系水平上育种值的描述性统计参数
# 嵌套分组层次，默认同trait.family.nested.term
tep.table.trait.family.nested.term = c("EnvLabel","","EnvLabel")
# 每个性状条件组合对应的描述
tep.table.trait.family.nested.term.label = c("养殖模式","","养殖模式")

# 画出家系水平上育种值的箱形图
tep.boxplot.trait.family.nested.term = c("EnvLabel","","EnvLabel")
# 每个性状条件组合对应的描述
tep.boxplot.trait.family.nested.term.label = c("养殖模式","","养殖模式")

# 家系水平上目标性状表型值与EBV的散点图，以及家系的EBV点图
# 嵌套分组层次默认同trait.family.nested.term
tep.trait.family.nested.term = c("EnvLabel","","EnvLabel")
#----------------end--------------------------------------------





#--------------------6.育种群体目标性状的遗传分析------------
# 是否展示育种目标性状的实现遗传进展。TRUE：展示，FALSE：不展示
is.realized.genetic.gain = c(TRUE, FALSE, FALSE)

# 是否展示育种目标性状的预测遗传进展。TRUE：展示，FALSE：不展示
is.predicted.genetic.gain = c(TRUE, FALSE, FALSE)

# 基于rmarkdown语法的实现遗传进展表格，手动输入
trait.realized.genetic.gain.table <-
  c(
    paste(
      "世代           | 群体        | 家系数量  | 个体数量 | 最小二乘均值 | 遗传增益 | 百分比（%） |\n",
      "-------------- | ----------- | --------- | -------- | ------------- | -------- | ----------- |\n",
      "2017G01(2016)  | 选择组      | 105       | 14845    | 33.93         |  4.87    | 16.76       |\n",
      "2017G01(2016)  | 对照组      | 15        | 2006     | 29.06         |  /       |  /          |\n",
      "2018G02(2016)  | 选择组      | 114       | 22180    | 41.51         |  4.06    | 11.02       |\n",
      "2018G02(2016)  | 对照组      | 15        | 2879     | 37.39         |  /       |  /          |\n",
      sep = ""
    ),
    "",
    ""
  )
  
# 基于rmarkdown语法的预测遗传进展表格（生长和存活率）
trait.predicted.genetic.gain.table <-
  c(
    paste(
      "世代           | 家系数量   | 个体数量 | 育种值（g） | 遗传增益（g） | 百分比（%）       |\n",
      "-------------- | ---------- | -------- | ------------| ------------- | ----------------- |\n",
      "2016G00(2016)  | 78         | 8361     |  0.3589     |  /            |  /              |\n",
      "2017G01(2016)  | 120        | 16851    |  3.5702     |  3.21         | 8.59-11.05       |\n",
      "2018G02(2016)  | 129        | 25059    |  6.3436     |  2.77         | 7.41-9.53       |\n",      
      sep = ""
    ),
    "",
    ""
  )
#----------------end--------------------------------------------






#--------------------7.育种群体目标性状选择指数和家系性能------------
# 是否绘制基于个体水平的育种目标性状育种值与选择指数的散点图
is.selection.index.ebv.individ = c(TRUE, FALSE, FALSE)

# 个体选择指数文件名称，可以单独提供，也可以跟性状测试数据文件trait.individ.filename为同一个文件。
trait.individ.sel.index.filename = c("SFMR2018G02GrowthSurSelIndexG02.csv", "", "") 

# 基于哪种条件组合产生的数据集，绘制个体水平上的散点图
# 默认同trait.individ.nested.term
tsi.trait.individ.nested.term = c("Generation, SexID", "", "")


# 是否绘制基于家系水平的育种目标性状育种值与选择指数的散点图
is.selection.index.ebv.family = c(TRUE, FALSE, TRUE)

# 家系选择指数文件，可以单独提供，也可以跟性状测试数据文件trait.family.filename为同一个文件
trait.family.sel.index.filename = c("SFMR2018G02FamilySummaryperGenerationEnvTankIDG02.csv", "","SFMR2018G02FamilySummaryperGenerationEnvTankIDG02.csv")

# 基于哪种条件组合产生的数据集，绘制家系水平上的散点图
# 用法同trait.family.nested.term
tsi.trait.family.nested.term = c("Generation", "","Generation")

# 是否展示家系的选择指数
is.selection.index = TRUE

# 家系选择指数点图嵌套分组层次,这个不针对性状
# 用法：两层嵌套：trait.individ.nested.term = c("Generation,TankID"),注意不要再包括FamilyID
tsi.trait.selection.index.nested.term = c("Generation")
# 条件组合对应的描述
tsi.trait.selection.index.nested.term.label = c("世代") #其中的逗号为英文逗号,中间不要有空格
#----------------end--------------------------------------------






#-----------------------------图形参数调整（不熟悉请不要调整）---------------

#通用
default_theme <- theme_gray(base_size = 16,base_family = "wqy-microhei")+theme(
  axis.title.x=element_text(size=16),
  axis.title.y=element_text(size=16),
  axis.text.x=element_text(size=14),
  axis.text.y=element_text(size=14),
  axis.ticks = element_line(size = 0.1),
  legend.position = "none",
  panel.border = element_blank()
)

# 家系间亲缘系数热图
coancestry_heatmap_theme <- theme_gray(base_size = 16,base_family = "wqy-microhei")+theme(
  axis.title.x=element_text(size=16),
  axis.title.y=element_text(size=16),
  axis.text.x=element_text(angle = 90, hjust = 1, size=6),
  axis.text.y=element_text(size=6),
  axis.ticks = element_line(size = 0.1)
)

# 奠基者群体组成面积图
founder_pop_area_theme <- theme_gray(base_size = 16,base_family = "wqy-microhei")+theme(
  axis.title.x=element_text(size=16),
  axis.title.y=element_text(size=16),
  axis.text.x=element_text(size=14),
  axis.text.y=element_text(size=14),
  axis.ticks = element_line(size = 0.1)
)
#家系生产同步性分布柱状图
family_birthday_bar_theme <- theme_gray(base_size = 16,base_family = "wqy-microhei")+theme(
  axis.title.x=element_text(size=16),
  axis.title.y=element_text(size=16),
  axis.text.x=element_text(size=14,angle = 45, hjust = 1),
  axis.text.y=element_text(size=14),
  axis.ticks = element_line(size = 0.1),
  legend.position = "none",
  panel.border = element_blank()
)

#个体水平上性状的统计性描述箱形图
theme.3 <- theme_gray(base_size = 16,base_family = "wqy-microhei")+theme(
  axis.title.x=element_text(size=16),
  axis.title.y=element_text(size=16),
  axis.text.x=element_text(size=14,angle = 0),
  axis.text.y=element_text(size=14),
  axis.ticks = element_line(size = 0.1),
  legend.position = "none",
  panel.border = element_blank()
)

#家系水平上性状的统计性描述箱形图
family_phenotype_boxplot_theme <- theme_gray(base_size = 16,base_family = "wqy-microhei")+theme(
  axis.title.x=element_text(size=16),
  axis.title.y=element_text(size=16),
  axis.text.x=element_text(size=14,angle = 0),
  axis.text.y=element_text(size=14),
  axis.ticks = element_line(size = 0.1),
  legend.position = "none",
  panel.border = element_blank()
)

#家系水平上育种值和选择指数点柱状图
theme.family.ebv.bar.point.axis.text.x.angel.90 <- theme_gray(base_size = 16,base_family = "wqy-microhei")+theme(
  axis.title.x=element_text(size=16),
  axis.title.y=element_text(size=16),
  axis.text.x=element_text(size=12,angle = 90, hjust=1),
  axis.text.y=element_text(size=12),
  axis.ticks = element_line(size = 0.1),
  legend.position = "none",
  panel.border = element_blank()
)

#----------------end------------------------------

######以下参数请不要修改#####
#家系信息文件路径初始化
data_directory = "Data/"
FamilyInfo = paste(data_directory, family.file.name, sep = "") #家系文件信息
#系谱文件路径初始化
pedigree.file.name.path = paste(data_directory, pedigree.file.name, sep = "")

#基础参数
species.latin.name = paste("*",species.latin.name,"*",sep="")
#描述性统计分析文件的路径初始化
data.individ.trait <-
  vector("character", sum(is.individ.stats,na.rm=TRUE))
data.individ.trait.sel.index <-
  vector("character", sum(is.individ.stats,na.rm=TRUE))
data.family.trait <-
  vector("character", sum(is.family.stats,na.rm=TRUE))
data.family.trait.sel.index <-
  vector("character", sum(is.family.stats,na.rm=TRUE))
  
for (i in 1:length(trait.individ.filename)) {
  data.individ.trait[i] = paste(data_directory, trait.individ.filename[i], sep = "")
  data.individ.trait.sel.index[i] = paste(data_directory, trait.individ.sel.index.filename[i], sep = "")
}

for (i in 1:length(trait.family.filename)) {
  data.family.trait[i] = paste(data_directory, trait.family.filename[i], sep = "")
  data.family.trait.sel.index[i] = paste(data_directory, trait.family.sel.index.filename[i], sep = "")
}

#定义图和表的计数器
fig.counter <- 0
table.counter <- 1

