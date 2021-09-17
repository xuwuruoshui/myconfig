修改`/etc/nginx/conf.d/xx.conf`

- http配置

```nginx
# 普通的80端口配置
server{ 
    # 监听端口，服务器名称
    listen       80;
    server_name  xxx.com;
    client_max_body_size 1000m;
    location ^~ / {
       # 匹配到/后，代理到http://127.0.0.1:4999
       proxy_pass http://127.0.0.1:4999/;
       proxy_redirect off;
       proxy_connect_timeout 90;
       proxy_send_timeout 90;
       proxy_read_timeout 90;
       proxy_set_header Host $host;
       proxy_set_header X-Real-IP $remote_addr;
       proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
       proxy_set_header http_user_agent $http_user_agent;
    }
}
```

- https

```nginx
# 443端口配置
server { 
    listen       443;
    server_name  xxx.com;
    # ssh配置
    ssl on; 
    ssl_certificate /etc/nginx/ssl/test.crt;
    ssl_certificate_key /etc/nginx/ssl/test.key;
    ssl_session_timeout 5m; 
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:HIGH:!aNULL:!MD5:!RC4:!DHE;
    ssl_prefer_server_ciphers on; 
    client_max_body_size 1000m;
    # 路径匹配
    location ^~ / { 
       proxy_pass http://127.0.0.1:4999/;
       proxy_redirect off;
       proxy_connect_timeout 90; 
       proxy_send_timeout 90; 
       proxy_read_timeout 90; 
       proxy_set_header Host $host;
       proxy_set_header X-Real-IP $remote_addr;
       proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
       proxy_set_header http_user_agent $http_user_agent;
    }   
}

# http跳转https	
server{
    listen 80;
    server_name xxx.com;
    rewrite ^/(.*)$ https://xxx.com:443/$1 permanent;
}
```

