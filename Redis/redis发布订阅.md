# redis发布订阅

## 是什么

进程间的一种通信模式：发送者（pub）发送消息，订阅者（sub）接受消息。
订阅/发布消息图

## 命令

- PSUBSCRIBE pattern[pattern] 订阅一个或多个符合给定模式的频道
- PUBSUB subcommand[argument[argument]] 查看订阅与发布系统状态
- PUBLISH channel message 将消息发送到指定的频道
- PUNSUBSCRIBE [pattern[pattern]] 退订所有给定模式的频道
- SUBSCRIBE channel[channel...]订阅给定的一个或多个频道的信息
- UNSUBSCRIBE [channel[channel]] 退订给定的频道

## 案例
