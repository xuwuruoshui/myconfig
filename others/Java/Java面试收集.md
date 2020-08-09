#  Java基础

## 常识
Java中基本数据类型是什么,各自占用多少字节
byte(1) short(2) int(4) long(8) float(4) double(8) boolean(1/8字节 1bit) char(2)

## 关键字
> statis用途
创建工具类时里面的属性或者方法加上static,可以使用类名.属性/方法调用
配合final定义全局常量
定义全局变量，多个实例共用一个变量


##　String
> String能被继承吗?
不能，String类有final修饰
> String,Stringbuffer,StringBuilder的区别
String为字符串常量,是不可变的对象,所以每次操作String得到的新的字符串其实是创建了一个新的String对象，然后将指针指向了String对象。经常要修改字符串就不要用String，否则内存中多了无引用的对象就会启动GC，速度会有所影响。

StringBuffer是字符串变量，对变量进行操作是对对象进行更改，而不进行创建和回收的操作，速度比String快很多

StringBuilder和StringBuffer类似，但会快一些，因为它不是是线程安全的。
## 面向对象

> 面向对象的3个特征?
封装,集成,多态

> 类的实例化顺序
执行父类的静态属性，静态代码块，静态方法---->执行子类的静态属性，静态代码块，静态方法---->执行父类的属性，代码块，方法，构造方法---->执行子类的属性，代码块，方法，构造方法

>抽象类和接口的区别,类可以继承多个类么,接口可以继承多个接口么,类可以实现多
个接口么
1、抽象类和接口都不能直接实例化，如果要实例化，抽象类变量必须指向实现所有抽象方法的子类对象，接口变量必须指向实现所有接口方法的类对象。

2、抽象类要被子类继承，接口要被类实现。

3、接口只能做方法申明，抽象类中可以做方法申明，也可以做方法实现

4、接口里定义的变量只能是公共的静态的常量，抽象类中的变量是普通变量。

5、抽象类里的抽象方法必须全部被子类所实现，如果子类不能全部实现父类抽象方法，那么该子类只能是抽象类。同样，一个实现接口的时候，如不能全部实现接口方法，那么该类也只能为抽象类。

6、抽象方法只能申明，不能实现。abstract void abc();不能写成abstract void abc(){}。

7、抽象类里可以没有抽象方法

8、如果一个类里有抽象方法，那么这个类只能是抽象类

9、抽象方法要被实现，所以不能是静态的，也不能是私有的。

10、接口可继承接口，并可多继承接口，但类只能单根继承。

ps:接口和抽象类的区别,接口的变量为常量必须赋值,方法不能都方法体。抽象类反之。

> Integer问题
-128-127会自动缓存,使用==和equals都可比对两个相同的值为true,在此范围外都将会创建新的对象,所以只能用equals比较值。


## 集合

> HashMap与Hashtable有什么区别?

| 区别               | HashMap | Hashtable |
| :----------------- | ------- | :-------: |
| 键值对是否可以为空 | 可以    |  不可以   |
| 线程是否安全       | 不安全  |   安全    |

> HashMap具体实现

负载因子 0.75
数组entry 16

- 首先HashMap采用了数组+链表+红黑树.
- 存储数据时会先把key的hashcode进行移位，再与数组长度减1进行&操作设置数组的位置，查询时只需要取余就能找到具体位置了.
- 确定存在hashcode相等的时候,这个时候就会用到链表,相同的hashcode不同的key的元素就会放到前一个对象的next属性中.
- 当然链表过长查询效率会降低,所以链表长度超过8后,会转为红黑数去提示效率
- 关于扩容,当数组占用达到负载因子和数组长度的乘积时就会扩容,创建一个比初始容量大1倍的数组，遍历原来数组,将链表上的数组再一一遍历拷贝到新的数组上面去
- 如果key为null，hashcode默认为0，会将数据存在数组的第一位

> HashMap的负载因子为什么为0.75

- 如果负载因子小了,虽然查询效率提高了,但是空间浪费太多了
- 如果负载因子大了,空间节省了,但链表或者红黑树变长了效率就低了,以及扩容时会rehash,将数组里面的数据放到新的数组中,很耗性能

> 创建一个HashMap的实例，里面put若干元素，循环遍历时调用HashMap的remove方法会报错为什么?

HashMap在遍历时，会初始化一个叫expectedModCount，值等于HashMap的modCount。在遍历时调用HashMap的remove会将modCount++，每次循环会将modCount与expectedModCount比对，显然不同，会抛出异常(fail-fast 快速失败机制)。如果非要移除，可以调用iterator的remove方法，这个会将expectedModCount和modCount再一次的赋值。

>用过那些Map的实现类，他们有什么区别

HashMap，线程不安全，底层用的数组+链表+红黑树

HashTable，线程安全，但很多方法中都加了synchronize关键字,太慢了。key,value都不能为null

ConcurrentHashMap，线程安全，使用CAS+Synchronize。底层用的数组+链表+红黑树的存储结构，和HashMap一样。

TreeMap，线程非安全，不允许键值为null，实现了SortMap接口，可以自定义排序

LinkedHashMap，线程非安全，允许key和value为空，有序

> ArrayList和LinkedList有什么区别

ArrayList的底层实现是链表是Object[]，数组自然查询快，中间插入删除数据慢
LinkedList则是底层实现是链表，自然查询速度慢,增删数据快

> ArrayList(HashSet类似)线程安全吗

不安全，比较modCount不同时就会抛出ConcurrentModificationException，可以使用Vector、Collections.synchronizedList、CopyOnWriteArrayList。但是Vector的实现大多用的Synchronized，而CopyOnWriteArrayList用的是Lock。CopyOnWriteArrayList，底层是写入前先复制一份当前数据，add添加完后，再将新数据覆盖旧数据。

HashSet的底层
HashSet的底层是HashMap


## 线程
> 进程和线程

进程有独立的地址空间，一个进程崩溃后，在保护模式下不会对其他进程产生影响。

线程是一个进程中不同的执行路径，线程有自己的堆栈和局部变量，但线程之间没有单独的地址空间，一个线程死掉就等于整个进程死掉，所以多线程的程序要比多线程的程序健壮，但是进程切换时，消耗资源较大，效率要差一些。但对于一些要求同时进行并且又要共享某些变量的并发操作，只能用线程，不能用进程。

> 线程有哪几种状态

NEW: 新建
RUNNABLE: 运行
BLOCKED: 阻塞
WAITING: 等待(一直等)
TIMED_WAITING: 超时等待(超时后就不等了)，
TERMINATED: 终止

![](./img/status.png)

> wait/sleep的区别

wait是Object类，sleep是Thread类
wait会释放锁,sleep不会释放
wait必须在同步代码块中，sleep可以再任何地方休眠

> Synchronized和Lock的区别

1、Synchronized 内置Java关键字，Lock Java类
2、Synchronized 无法判断获取锁的状态，Lock 可以判断是否获取到锁
3、Synchronized 会自动释放锁，lock 必须要手动释放锁
4、Synchronized 线程1阻塞，线程2就会一直等待，Lock 不一定会一直等待
5、Synchronized 可重入锁，不可中断，非公平，Lock，可重入锁，可以中断，可以手动设置是否公平
6、Synchronized 适合锁少量代码同步问题，Lock适合锁大量的同步代码块

> static属性，线程锁的是什么

普通属性锁实例，static锁Class.锁不同自然可以同时执行。

> Runnable和Callable的区别

Callable有返回值，会抛出异常,可以用泛型
Runnable调用run(),Callable调用call()

> 最大线程该如何定义

1. CPU密集型, 几核,就是几，可以保持CPU效率最高
2. IO密集型 判断程序中十分耗IO的线程

> Forkjoin

将多个任务拆分为多个任务，当其中一个子任务执行完后会去窃取其他子任务未完成的。最后各个任务又合并为一个任务。

> Volatile

是Java虚拟机提供轻量的同步机制
1、保证可见性
2、不保证原子性
3、禁止指令重排

> volatile可以避免指令重排

1、内存屏障，保证特定操作的执行顺序
2、可以保证某些变量的内存可见性(利用了这些特性volatile实现了可见性)(DCL懒汉式)

> CAS是什么?

比较当前工作中的值和主内存中的值，如果这个值是期望的，那么执行操作，不是就一直循环直到值是期望的。底层是自旋锁。
缺点：
1、循环会耗时
2、一次性只能保持一个共享变量的原子性
3、ABA问题
AtomicXXX compareAndSet(当前值,新值)

> ABA问题

引入原子引用，带版本号的原子操作(AtomicStampedReference),CAS多了两个参数
AtomicStampedReference compareAndSet(当前值,新值,当前版本,新版本)

> 公平锁和非公平锁

公平锁不允许插队
非公平锁允许插队

> 可重入锁

获取到第一把锁，自动获取到里面的第二把锁,后面来的B线程只有等待A线程执行完成。

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
