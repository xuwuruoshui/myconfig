# V2ray+ws+tls+bbr+cloudflard搭建

## 1. cloudflard
添加A。www,服务器ip地址
添加txt。txt记录，记录值

## 2. tls
1. https://freessl.cn/orderlist获取tls
2. 获取txt记录，记录值。点测试有两个通过就可以用。
3. 下载私钥，创建一个域名+`.key`的文件
4. https://www.myssl.cn/tools/merge-pem-cert.html
   - 勾选PEM
   - 将私钥复制上去
   - 勾选自动添加中间证书,生成`pem`文件
   - 将其名字改为域名+`.`
5. 在`/etc/`下创建域名的文件夹, 将配置文件上传到该文件夹中.

## 3. bbr
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
2. 443端口,ws(path:youku.com),tls,域名www.xxx.xxx,证书路径，私钥路径
3. 拷贝config.json文件到服务器`/etc/v2ray`下覆盖
4. `systemctl restart v2ray`
5. 点击生成链接,扫描二维码，修改伪装地址为https://iqiyi.com

