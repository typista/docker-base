#http://qiita.com/hnakamur/items/0b72590136cece29faee
FROM centos:centos6
RUN yum update -y
RUN yum install -y wget which git curl tar zip bzip2 make gcc-c++ zlib-devel crontabs
RUN yum install -y wget openssl openssl-devel
ADD files/vimrc /etc/skel/.vimrc
ADD files/vimrc /root/.vimrc
RUN echo "umask 002" >> /etc/skel/.bashrc

ADD files/execme1st.sh /root/
ADD files/services.sh /etc/services.sh
RUN chmod +x /etc/services.sh
ENTRYPOINT /etc/services.sh

