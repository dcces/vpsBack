#!/bin/bash
tempPath='/home/temp'
fileName=''
#qiniuBucket="my-vps-back"
#qiniuAccessKey="hJ86nS19DGzMtTaTnC60i3YoJefeRI7raa7Pu5lc";
#qiniuSecretKey="n26ONZ_wF8_kmOuqzWrq18ETCMRPTAGtvm6jjUBT";
#mkdir $tempPath
#zip -q $tempPath/a.zip $backPath

log(){
    echo $1
}
# create temp directory
mkdirTempPath(){
    if [ ! -x "$1" ];
    then 
        mkdir "$1"
    fi
}
# create file zip
createTempFile(){
    log "开始保存至临时文件"
    NOW=$(date +"%Y%m%d%H%M%S")
    fileName=$NOW.zip
    zip -q -r $tempPath/$fileName $backPath
    log "临时文件保存成功。路径：$tempPath/$fileName"
}
uploadToQiNiu(){
    log '开始上传到七牛云'
    ./qshell  rput $qiniuBucket $fileName $tempPath/$fileName
    log '上传到七牛云成功'
}

qiNiuInit(){
    if [ ! -f 'qshell' ]; then
        yum install -y unzip zip
        wget http://devtools.qiniu.com/qshell-linux-x64-v2.4.2.zip
        unzip qshell*.zip
        mv qshell-linux-x64-v2.4.2 qshell
        ./qshell account $qiniuAccessKey $qiniuSecretKey $qiniuAccessKey
    fi
}
#which "unzip" > /dev/null
#if [ $? -eq 0 ]
#then
#    echo command is exist
#else
#    echo command not exist
#fi

source config.ini
qiNiuInit
mkdirTempPath $tempPath
createTempFile
uploadToQiNiu
