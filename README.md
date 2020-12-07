# fastdfs-nginx-kubernetes

fastdfs 的k8s 版
fastdfs 在docker 上會有gateway的問題
所以通常只能找到docker-compose run 起的範例
那這版算是我用host-only的docker網路的試作版

### How to build
```
docker build -t=<DOCKER NAME> .
```
### How to run
```
下載我的另一個repo
git clone https://github.com/siangyeh8818/helm-example.git
cd helm-example
helm upgrade --create siang-fastdfs
```

