FROM ubuntu:18.04
ENV TZ=Asia/Shanghai

RUN sed -i "s@http://.*archive.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list \
    && sed -i "s@http://.*security.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list 

RUN echo "${TZ}" > /etc/timezone \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && apt update \
    && apt install -y wget \
                    openssh-server \
                    vim \
                    tzdata \
    && rm -rf /var/lib/apt/lists/* \
    && dpkg-reconfigure -f noninteractive tzdata \
    && apt-get clean \
    && apt-get autoclean \
    && echo 'root:root' | chpasswd \
    && echo "Port 233" >> /etc/ssh/sshd_config \
    && echo "PermitRootLogin yes" >> /etc/ssh/sshd_config 

COPY startup_run.sh /root/

RUN chmod 777 /root/startup_run.sh \
    && echo "# startup run \nif [ -f /root/startup_run.sh ]; then \n\t./root/startup_run.sh \nfi" >> /root/.bashrc
