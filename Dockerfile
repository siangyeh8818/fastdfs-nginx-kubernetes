#FROM siangyeh8818/club-fastdfs:base
FROM centos:7

RUN yum -y install gcc gcc-c++ libstdc++-devel pcre pcre-devel zlib zlib-devel openssl openssl-devel wget make
RUN yum -y groupinstall 'Development Tools'
RUN wget https://github.com/happyfish100/libfastcommon/archive/V1.0.7.tar.gz 
RUN tar -zxvf  V1.0.7.tar.gz
WORKDIR /libfastcommon-1.0.7
RUN ./make.sh ; ./make.sh install
RUN ln -s /usr/lib64/libfastcommon.so /usr/local/lib/libfastcommon.so ; ln -s /usr/lib64/libfastcommon.so /usr/lib/libfastcommon.so;  ln -s /usr/lib64/libfdfsclient.so /usr/local/lib/libfdfsclient.so ;  ln -s /usr/lib64/libfdfsclient.so /usr/lib/libfdfsclient.so 
WORKDIR /
RUN wget https://github.com/happyfish100/fastdfs/archive/V5.05.tar.gz ; tar -zxvf V5.05.tar.gz
WORKDIR /fastdfs-5.05
RUN ./make.sh ; ./make.sh install
RUN ln -s /usr/bin/fdfs_trackerd /usr/local/bin ; ln -s /usr/bin/fdfs_storaged /usr/local/bin ; ln -s /usr/bin/stop.sh /usr/local/bin ; ln -s /usr/bin/restart.sh /usr/local/bin
WORKDIR /
RUN  wget -c https://nginx.org/download/nginx-1.12.1.tar.gz ; tar -zxvf nginx-1.12.1.tar.gz
RUN wget https://github.com/happyfish100/fastdfs-nginx-module/archive/5e5f3566bbfa57418b5506aaefbe107a42c9fcb1.zip ; unzip 5e5f3566bbfa57418b5506aaefbe107a42c9fcb1.zip ; mv fastdfs-nginx-module-5e5f3566bbfa57418b5506aaefbe107a42c9fcb1  fastdfs-nginx-module-master
WORKDIR /nginx-1.12.1
RUN ./configure --add-module=/fastdfs-nginx-module-master/src ; make ; make install
WORKDIR /fastdfs-5.05/conf/
RUN  cp anti-steal.jpg http.conf mime.types /etc/fdfs/
COPY nginx.conf  /usr/local/nginx/conf/
COPY tracker.conf.tpl /etc/fdfs
COPY storage.conf.tpl /etc/fdfs 
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
WORKDIR /
ENTRYPOINT ["/bin/bash" "-c" "/docker-entrypoint.sh"]
