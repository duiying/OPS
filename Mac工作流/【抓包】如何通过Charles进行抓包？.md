# 【抓包】如何通过 Charles 进行抓包？  

1. Charles -> Help -> SSL Proxying -> Install Charles Root Certificate on a Mobile Device or Remote Browser
2. 设置 -> 无线局域网 -> 配置代理 -> 手动 -> 配置服务器和端口
3. 访问 chls.pro/ssl 下载描述文件，在设置 -> 通用 -> 描述文件中安装描述文件
4. 在设置 -> 通用 -> 关于本机 -> 证书信任设置 中信任证书
5. 在 Charles 抓到的请求中右键 Enable SSL Proxying
