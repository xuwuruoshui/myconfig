# V2ray+ws+tls+bbr+cloudflard搭建

## 1. cloudflard
添加A。www,服务器ip地址
添加txt。记录值为freessl提供的值

## 2. tls
1. https://freessl.cn/orderlist 获取tls
2. 获取txt记录，记录值。点测试有两个通过就可以用
3. 返回之前的页面点击验证.验证成功后下载文件(私钥和pem证书)
4. 修改私钥和公钥的名字为域名地址（例如baidu.com.key baidu.com.pem)
5. 在`/etc/`下创建一个的文件夹(自己随便命个名字，其实可以不在etc下创建，但配置还是同一放etc下比较好), 将配置文件上传到该文件夹中.

## 3. bbr
>加速
```shell
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p
sysctl net.ipv4.tcp_available_congestion_control
lsmod | grep bbr
```
## 4. v2ray
```shell
sudo su
date -R
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
date -R
bash <(curl -L -s https://install.direct/go.sh)
```
json文件
1. https://v2.ziyls.com/
2. 自己指定端口,ws(path:youku.com),tls,域名www.xxx.xxx,证书路径，私钥路径
3. 拷贝config.json文件到服务器`/etc/v2ray`下覆盖
4. `systemctl restart v2ray`
5. 点击生成链接,扫描二维码，修改伪装地址为https://iqiyi.com

