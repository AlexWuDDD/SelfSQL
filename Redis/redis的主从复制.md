# redis的复制（Master/Slave）

## 是什么

也就是我们所说的主从复制，主机数据更新后根据配置和策略，自动同步到备机的master/slave机制，Master以写为主，Slave以读为主

## 能干嘛

- 读写分离
- 容灾恢复

## 怎么玩

1. 配从（库）不配主（库）
2. 从库配置： slaveof 主库IP 主库端口
    每次与master断开之后，都需要重新连接，除非配置进redis.conf文件
    Info replication
3. 修改配置文件细节操作
    - 拷贝多个redis.conf文件
    - 开启daemonize yes
    - Pid文件名字
    - 指定端口
    - Log 文件名字
    - Dump.rdb名字
4. 常用3招
    - 一主二仆
        1. Init
        2. 一个Master两个Slave
            从机只能读，不能写
        3. 日志查看
        4. 主从问题演示
    - 薪火相传
        1. 上一个Slave可以是下一个slave的Master,Slave同样可以接收其他slaves的连接和同步请求，那么该slave作为链条中下一个的master,可以有效减轻master的写压力
        2. 中途变更转向：会清除之前的数据，重新建立拷贝最新的
        3. Slaveof 新主库ip 新主库端口
    - 反客为主
        1. slaveof no one
        2. slaveof 新主库ip 新主库端口

## 复制原理

1. Slave启动成功连接到master后会发送一个sync命令
2. Master接到命令后启动后台的存盘进程，同时收集所有接收到的用于修改数据集命令，在后台进程执行完毕之后，master将传送整个数据文件到slave,以完成一次完全同步
3. 全量复制：slave服务在接受到数据库文件后，将其存盘并加载到内存中
4. 增量复制：Master继续将新的所收集到的修改命令依次传给slave,完成同步，但是只要重新连接master,一次完全同步（全量复制）将被自动执行

## 哨兵模式（sentinel）

- 是什么
    反客为主的自动版，能够后台监控主机是否故障，如果故障了根据投票自动将库转换为主库

- 怎么玩
    1. 调整结构， 6379带着80、81
    2. 自定义的/myredis目录下新建sentinel.conf文件，名字绝不螚错
    3. 配置哨兵，填写内容
        - sentinel monitor 被监控数据库名字（自己起名字） 127.0.0.1 6379 1
        - 上面最后一个数字1,表示主机挂掉后salve投票看让谁接替成为主机，得票数多后成为主机
    4. 启动哨兵
        - Redis-sentinel /myredis/sentinel.conf

- 一组sentinel能同时监控多个Master

## 复制的缺点

- 复制延时
    由于所有的写操作都现在master上操作，然后同步到slave上，所以从master同步到slave机器肯定有一定的延迟，当系统很繁忙的时候，延迟问题会更加严重，slave机器数量的增加也会使这个问题更加严重。