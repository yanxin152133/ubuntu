FROM ubuntu:18.04
RUN sed -i "s@http://.*archive.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list \
    && sed -i "s@http://.*security.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list 

RUN apt update \
    && apt install -y wget \
                    openssh-server \
                    vim \
                    tmux \
                    net-tools \
                    git \
    && echo 'root:root' | chpasswd \
    && service ssh start

ENV TimeZone=Asia/Shanghai
# 使用软连接，并且将时区配置覆盖/etc/timezone
RUN ln -snf /usr/share/zoneinfo/$TimeZone /etc/localtime && echo $TimeZone > /etc/timezone

CMD ["/usr/sbin/sshd","-D"]