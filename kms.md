# 1、docker拉取vlmcsd
1. docker pull mikolatero/vlmcsd
2. docker run -itd -p 1688:1688 --restart=on-failure:5 imagesid

# 2、激活windows
1. 卸载已有激活key
```shell
cscript slmgr.vbs -upk 
```
2. 安装新的GVLK
```shell
cscript slmgr.vbs -ipk 33PXH-7Y6KF-2VJC9-XBBR8-HVTHH
```
- Windows 7 专业版：FJ82H-XT6CR-J8D7P-XQJJ2-GPDD4
- Windows 8 专业版：NG4HW-VH26C-733KW-K6F98-J8CK4
- Windows 8.1 专业版：GCRJD-8NW9H-F2CDX-CCM8D-9D6T9
- Windows 10 专业版：W269N-WFGWX-YVC9B-4J6C9-T83GX
- [more](https://github.com/Wind4/vlmcsd/tree/gh-pages)
3. 填写KMS服务器域名或者IP地址（会默认1688端口激活）
```shell
cscript slmgr.vbs -skms 192.168.0.108
```
4. 尝试连接KMS服务器在线激活（attempt online）
```shell
cscript slmgr.vbs -ato 
```
5. 显示激活信息
```shell
cscript slmgr.vbs -dlv
```

# 3、激活office
1. 进入安装目录
```shell
cd C:\Program Files\Microsoft Office\Office15
```
2. 立刻尝试激活
```shell
cscript ospp.vbs /act
```
3. 显示激活信息
```
cscript ospp.vbs /dstatus
```

> 转载自:http://www.bewindoweb.com/240.html