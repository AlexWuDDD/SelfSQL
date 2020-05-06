# Show Profile

## 是什么

是MySQL提供可以用来分析当前会话中语句执行的资源消耗情况。可以用于SQL调优的测量。

默认情况下是关闭，并保存最近15次的运行结果。

### 开启

> show variables like '%profiling%';
>
>set profiling=on;
>

## 分析步骤

### 运行SQL

### 查看结果