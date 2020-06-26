# 简介
遗传评估报告生成系统（the system of Dynamic Report Generation for Genetic Evaluation, **DRGGE**)，主要功能是读取格式化的育种观测数据和利用asreml等软件分析后的育种值和选择指数等结果，生成一个遗传评估报告（docx格式），直观地给出**家系结构、家系生产同步性，育种群体的系谱完整度、近交系数、共亲系数、奠基者群体占比（图1），育种目标性状的描述统计参数、遗传力、育种值、遗传进展、选择指数**等信息，对育种群体进行系统、全面的评估，为下一步配种方案制定、育种方案优化等奠定坚实的数据基础。

完整的遗传评估报告包括以下几部分：

* 育种材料与方法
* 结果
    * 育种群体家系的构建分析
    * 育种群体的系谱分析
    * 育种群体目标性状的描述性统计分析
    * 育种群体目标性状的遗传参数估计
    * 育种群体目标性状的育种值预测
    * 育种群体目标性状的遗传进展分析
    * 育种群体目标性状选择指数和家系性能
* 讨论

![图1 Mainutf8.docx外观](https://github.com/luansheng/DRGGE/blob/master/Image/Mainutf8.png)

DRGGE主要是利用R语言，在Rstudio客户端完成。在编写过程中，使用Markdown文档标记进行书写，表通过knitr包中的kable输出，图通过ggplot2包输出。数据分析用用到了dplyr包和data.table包，系谱分析用到了optiSel包。Rstudio在后台调用rmarkdown、knitr、pandoc等R包，把书写的Rmd格式转换为docx格式。

# 安装
如果在本地安装，用到的软件主要包括：       
1. R [R网站](https://www.r-project.org/), 务必要下载使用64位版本      
2. Rstudio 最新版 [Rstudio windows客户端](http://www.rstudio.com/products/rstudio/download/)       
3. 打开Rstudio，菜单栏Tools -> Install Packages...  安装需要的R包，主要包括：
  * dplyr
  * ggplot2
  * data.table
  * optiSel
  * knitr
  * pander
  * rmarkdown
4. 查看rmarkdown已经安装的Pandoc版本。在rstudio控制台中载入rmarkdown包后，输入pandoc_version()查看。      
5. 如果Pandoc版本号低于2.0，需要升到2.0版本以上。[下载地址](http://pandoc.org/installing.html)        

安装完成后，在Rstudio中打开参数文件parameters.R和Mainutf8.Rmd两个文件，在前者中编辑各种参数，然后运行后者，输出报告。

# 使用
1. 为了确保程序正常运行和输出，DRGGE系统使用到的所有数据文件和程序文件，**务必请设定为utf-8格式**。

* Rstudio设置为utf-8的方法：
* Tools -> Global options -> coding -> saving -> default text encoding: UTF-8.
* 数据文件的编辑，建议使用ultraedit、notepad++等工具。推荐直接使用notepad++，新文件编码默认为utf-8。

2. 首先在Rstudio中打开parameter.r 文件，输入各项参数。详细说明，见参数文件的注释。       
3. 然后在rstudio中打开Mainutf8.Rmd文件，点击knitr，会自动生成Mainutf8.docx文件。注意每次重新knitr前，需要关闭Mainutf8.docx文件，否则会出现错误。
