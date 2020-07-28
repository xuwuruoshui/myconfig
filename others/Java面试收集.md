#  Java基础

##　String

## 面向对象

> 面向对象的3个特征?

封装,集成,多态

## 集合

> HashMap与Hashtable有什么区别?

| 区别               | HashMap | Hashtable |
| :----------------- | ------- | :-------: |
| 键值对是否可以为空 | 可以    |  不可以   |
| 线程是否安全       | 不安全  |   安全    |

> HashMap具体实现

- 首先HashMap采用了数组+链表.
- 存储数据时会通过key的hashcode与数组长度取余确定数组的位置,那么查询还是通hashcode取余效率就比较高了.
- 那么肯定存在hashcode相等的时候,这个时候就会用到链表,相同的hashcode不同的key的元素就会放到前一个对象的next属性中.
- 当然链表过长查询效率会降低,所以链表长度超过8后,会转为红黑数去提示效率
- 关于扩容,当达到负载因子和初始容量的乘积时就会扩容,扩大初始容量的1倍

> HashMap的负载因子为什么为0.75

- 如果负载因子小了,虽然查询效率提高了,但是空间浪费太多了
- 如果负载因子大了,空间节省了,但链表或者红黑树变长了效率就低了,以及扩容时会rehash,将数组里面的数据放到新的数组中,很耗性能

## 线程

## 反射

##  JVM

## 部分API

> Java中==和equals的区别?

- ==是运算符,用于比较两个变量是否相等,对于基本数据类型而言比较的是变量的值,对于对象类型而言比较的对象是地址
- equals()是Object类的方法,默认实现使用的是==,通常如果只是想比较两个对象的值是否相等需要重写equals方法

> hashcode和equals的关系?

- 二者都是用来判断两个对象的否相同的方法.
- 通常情况下不需要重写hashcode,重写equals就可以了,但为了满足一些hashcode的一个准则:如果两个对象根据equals(Object)方法比较是相等的，那么调用这两个对象中的hashCode方法都必须产生同样的整数结果,那我们就应该手动去重写
- 用到HashMap,HashSet的时候,equals其实可以比对两个对象是否相同,但效率低,所以会先去比对hashcode,如果hashcode不同,那么这两个对象就不同,两个hashcode相同再对比equals.



# Spring

# MyBatis

# JPA

# 微服务

# 数据库
## MYSQL
>数据量很大,分页查询慢,如何优化?
当limit的偏移量(即第一个参数)特别大时查询速度 
1. 子查询
```sql
select * from orders_history where type=8 and
id>=(select id from orders_history where type=8 limit 100000,1)
limit 100;
```
2. id限定优化
```sql
select * from orders_history where type=2
and id between 1000000 and 1000100 limit 100;
```
```sql
select * from orders_history where id >= 1000001 limit 100;
```
3. in
```sql
select * from orders_history where id in
(select order_id from trade_2 where goods = 'pen')
limit 100;
```
> 乐观锁和悲观锁

乐观锁，当数据要改变的时候需要判断当前version是否符合规定，当数据修改成功后修改版本的version。比如两条sql同时执行，第一条先完成了修改，version也随之改变，那第二条拿到的version就无效了，sql执行并没有意义



> MySQL底层

- 采用B+Tree，非叶子节点不存储数据，只存储索引。

- 叶子节点包含所有索引字段

- 叶子节点用指针连接，提高访问性能

MySQL不用二叉数是由于，插入时可能单边一直增长，导致树的高度增加，导致查询次数非常多。红黑树虽然多了一点平衡机制(右边比左边多2个节点会重新修改节点),但数据越大，树的高度也上来了。B-Tree树(每个节点放指定个元素，大大降低了树的高度)还过得去，但是为了更大的提升性能.
B+Tree,就拿bigint(8字节来算)来存储。
- 非子节点都存索引不存数据。8字节+6字节(指向下一个节点的容量)。 默认mysql数据片大小为16K。16*1024/14 = 1170.
- 叶子节点，假如一个索引和一条数据的空间为1KB，那么起码一个节点就可以存16条数据。
- 那么如果树的高度为3,1170*1170*16 = 2000多万

> MySQL数据存放路径
`show variable like '%dir%'`
Windows放在data下
Linux放在/var/lib/mysql

> MySQL数据文件的含义
*MyISAM*
.frm 表结构,字段长度
.MYD 数据信息文件,存储数据信息
.MYI 索引信息文件
普通索引,叶子节点存指针

*InnoDB*
.ibd(独立表存储模式) 存储数据信息好索引信息
.ibdata1(共存储模式) 存储数据信息和索引信息
.part(分区存储) 用于存储分区信息
聚集索引,叶子节点存数据

> MyISAM和InnoDB之间的区别
MyISAM：不支持事务，锁表,非聚合索引，查询比较快
InnoDB：支持事务，必须有主键
MEMORY：数据放内存，默认使用哈希索引

> InnoDB为什么必须有主键？推荐用主键自增？
InnoDB底层B+Tree就是用主键来维护表中所有的数据。如果自己不设置，InnoDB会自动选一个字段内容不重复的设置为主键，没有那就系统自己建一个字段

> B+Tree和Hash
大部分情况下都用B+Tree,如果单查某个精确的值还hash远大于B+Tree,只需要对索引做一次hash就可以获取到地址，但是如果查询范围Hash就不行了,MySQL中的B+Tree存储数据的节点都会有双向指针。

> 数据库三范式
第一范式：每列不能再分为最小的数据单元
第二范式：满足第一范式，每张表只描述一件事情
第三范式：表中的列不存在对非主键列的传递依赖。比如A表中出现了B表中的一个非主键字段

> 数据库事务(ACID)
原子性：事物是一个完整的操作。要么都执行，要么都失败。
一致性：当事物完成时，数据必须处于一致状态。(比如转账前后，总数是不变的)
隔离性：数据进行修改的所有并发事物是彼此隔离的。一个事务无法影响另一个事务
持久性：事务完成后，持久到硬盘

> 事务隔离级别
read uncommited: 未提交读 读到了没有提交的数据(脏读)
read commited: 不可重复读 提交前读到的数据,和提交后的读到的数据不同(更新)(幻读)
repeatable read: 可重读 查询前的数据结果数和查询后数据结果数变了(插入 删除)(幻读)
serializable: 串行化 锁表

> MySQL当记录不存在时inserrt,当记录存在时update，语句怎么写
insert into interview (id,name,age) values(3,"yyyy",13)
on duplicate key update name ='hahaha',age = 15;

>查看为表格定义的索引
show index from tablename

>LIKE 声明中的%和_是什么意思?
模糊查询,%匹配多个字符，_匹配一个字符(只匹配一个字符).%和_在之前是索引不生效

>char和varchar区别
char固定长度不变,比如char(10)和varchar(10),如果存储'abc'，那么用char长度还是10,varchar则是3。char比varchar存取数据要快。char存储时英文字符占一个字节,中文2个字节,varchar中英文都是2个
## Oracle

# Linux

# TCP/IP

