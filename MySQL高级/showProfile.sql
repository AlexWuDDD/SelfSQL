SHOW VARIABLES LIKE '%profiling%';

SET profiling=ON;

SELECT empno%100000 FROM emp GROUP BY empno%100000 LIMIT 150000;
SELECT empno%200000 FROM emp GROUP BY empno%200000 ORDER BY 1;

SHOW PROFILES;

# 诊断SQL

SHOW PROFILE CPU, BLOCK IO FOR QUERY 21;
/*
ALL  显示所有的开销信息
BLOCK IO 显示块IO相关开销
CONTEXT SWITCHES 上下文切换相关开销
CPU 显示CPU相关开销信息
IPC 显示发送和接受相关开销信息
MEMORY 显示内存相关开销信息
PAGE FAULTS 显示页面错误相关开销信息
SOURCE 显示和SOurce_function, Source_file, Source_line相关的开销信息
SWAPS 显示交换次数相关开销的信息
*/

/*
日常开发需要注意的结论
- converting HEAP to MyISAM 查询结果太大，内存都不够用了往磁盘上搬了
- Creating tmp table 创建临时表
	- 拷贝数据到临时表
    - 用完再删除
- Copying to tmp table on disk 把内存中临时表复制到磁盘， 危险！！！
- locked


*/

SET profiling=OFF;