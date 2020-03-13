FROM centos:7

MAINTAINER xcq

# 需在当前目录下准备jdk安装包
COPY node-data/hadoop1/softwares/jdk-8u231-linux-x64.tar.gz /opt/jdk-8u231-linux-x64.tar.gz

# 环境变量
ENV JAVA_HOME=/usr/local/lib/jdk1.8.0_231 JRE_HOME=/usr/local/lib/jdk1.8.0_231/jre 
ENV PATH=${PATH}:${JAVA_HOME}/bin:${JRE_HOME}/bin

RUN \
  # 该证书避免yum下载时报warning
  rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 \
  # 调整容器的时间到东八区
  && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && echo 'Asia/Shanghai' >/etc/timezone \
  # 下载必要的工具 which是hdfs格式化时需要的 expect是ssh自动配置需要的 psmisc是hdfs ha所需要的
  && yum install -y net-tools openssh-server openssh-clients sudo which expect psmisc \
  # 删除下载缓存
  && yum clean all \
  # 添加新用户kfk
  && useradd kfk \
  # 为kfk用户设置密码
  && echo "kfk:kfk" | chpasswd \
  # 设置root密码为固定值1234
  && echo "root:1234" | chpasswd \
  # 让kfk在使用sudo时无需再输密码
  && echo "%kfk ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
  # 解压jdk 再删掉压缩包
  && tar -zxf /opt/jdk-8u231-linux-x64.tar.gz -C /usr/local/lib \
  && rm /opt/jdk-8u231-linux-x64.tar.gz \
  # 这主要是为了让容器在ssh连接时，能正确更新环境变量
  && echo "export $(sudo cat /proc/1/environ |tr '\0' '\n' | grep -v -E '^H|^T' | xargs)" >> /etc/profile \
  # 添加中文支持
  && echo 'export LANG="en_US.UTF-8"' >> /home/kfk/.bashrc \
  # 不知道什么原因，$USER这个环境变量会缺失，在此补上，不管root用户
  && echo "export USER=kfk" >> /home/kfk/.bashrc

# 让init成为前台进程，启动后不会秒退，并且，只有init成为1号进程才可以使用systemctl命令，当然，还需在特权模式运行
CMD ["/usr/sbin/init"]
