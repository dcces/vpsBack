# vpsBack
备份VPS数据

目前支持七牛云

## 使用步骤


1. 下载项目到本地

```
git clone https://github.com/dcces/vpsBack.git
```

2. 编辑cong.ini

```
# 公共配置
## 需备份的文件夹路径
backPath='/wwwroot/'

# 七牛云配置
## 空间名称
qiniuBucket=""
## AccessKey
qiniuAccessKey="";
## SecretKey
qiniuSecretKey="";
```

3. 添加执行权限

```
chmod -x start.sh
```

4. 手动执行一次

```
./start.sh
```

5. 定时任务配置

使用 **cron** 定时执行
```
crontab -e
```
进入cron编辑，按i进入编辑模式，在最后添加
```
30 21 * * * /root/start.sh
```
按 esc 键，输入 :wq，回车保存文件。

上述为每天晚上9点半自动执行