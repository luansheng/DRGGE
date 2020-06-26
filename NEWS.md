# Changes in version 1.0 released on 26 June 2020
## New features
1. 数据文件放置在Data文件夹中，删除了Data文件夹中的Input和Output目录      
2. 参数文件统一放置在Parameter文件夹中；       
3. 材料与方法描述RMD文件放置在MaterialMethod文件夹中；       
4. R脚本文件放置在R文件夹中；       
5. 结果分析RMD文件放置在Results文件夹中；        
6. 讨论RMD文档放置在Discussion文件夹下；        
7. docx模板文件放置在Style文件夹中。
   
# Changes in version 0.9 released on 05 Nov 2018
## New features
1. 更新pandoc到2.0，已经支持在mystyles.docx中设置表格为三线格样式,并且居中；           
2. 自动安装需要的包。 
## Bugs fixed         
1. 修改了部分图形主题的名称，输出图形字体为中文黑体；      
2. 修正计算相关系数时的一个bug：如果存在缺失数据，不能计算近交系数。

# Changes in version 0.8 released on 06 Mar 2018
## Bugs fixed
1. 修改summTest.Rmd中家系生产同步性柱状图，x轴日期坐标的显示方法。在158行，添加了scale_x_date(date_breaks = "5 days",labels=date_format("%m/%d"))函数，第一个参数控制x轴间隔，第二个控制日期的显示格式。