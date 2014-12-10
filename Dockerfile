#http://qiita.com/hnakamur/items/0b72590136cece29faee
FROM centos:centos6
ENTRYPOINT /etc/entrypoint.sh
RUN touch /etc/bashrc && \
	echo 'alias vi="vim"' >> /etc/bashrc && \
	touch /etc/skel/.bash_profile && \
	echo '# .bash_profile' >> /etc/skel/.bash_profile && \
	echo '# Get the aliases and functions' >> /etc/skel/.bash_profile && \
	echo 'if [ -f ~/.bashrc ]; then' >> /etc/skel/.bash_profile && \
	echo '. ~/.bashrc' >> /etc/skel/.bash_profile && \
	echo 'fi' >> /etc/skel/.bash_profile && \
	echo '# User specific environment and startup programs' >> /etc/skel/.bash_profile && \
	echo 'PATH=$PATH:$HOME/bin' >> /etc/skel/.bash_profile && \
	echo 'export PATH' >> /etc/skel/.bash_profile && \
	cp /etc/skel/.bash_profile /root/ && \
	touch /etc/skel/.bashrc && \
	echo 'alias vi="vim"' >> /etc/skel/.bashrc && \
	cp /etc/skel/.bashrc /root/ && \
	source /root/.bashrc && \
	echo 'umask 002' >> /etc/skel/.bashrc && \
	touch /etc/skel/.vimrc && \
	echo 'set encoding=utf-8' >> /etc/skel/.vimrc && \
	echo 'set fileencodings=utf-8,iso-2022-jp,sjis,euc-jp' >> /etc/skel/.vimrc && \
	echo 'set tabstop=4' >> /etc/skel/.vimrc && \
	echo 'set paste' >> /etc/skel/.vimrc && \
	cp /etc/skel/.vimrc /root/ && \
	yum update -y && \
	yum install -y vim wget which git curl tar zip unzip bzip2 make zlib-devel crontabs && \
	yum install -y wget openssl openssl-devel && \
    wget http://people.centos.org/tru/devtools-2/devtools-2.repo -O /etc/yum.repos.d/devtools-2.repo && \
	yum update -y && \
    yum install -y devtoolset-2-gcc devtoolset-2-binutils && \
    yum install -y devtoolset-2-gcc-c++ devtoolset-2-gcc-gfortran && \
	ln -s /opt/rh/devtoolset-2/root/usr/bin/* /usr/local/bin/ && \
	hash -r && \
	wget https://raw.githubusercontent.com/typista/docker-base/master/files/entrypoint.sh -O /etc/entrypoint.sh && \
	chmod +x /etc/entrypoint.sh

