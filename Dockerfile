#http://qiita.com/hnakamur/items/0b72590136cece29faee
FROM centos:centos6
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
	touch /etc/services.sh && \
	echo '#!/bin/bash' >> /etc/services.sh && \
	echo 'LOCALTIME=/etc/localtime' >> /etc/services.sh && \
	echo 'if [ ! -L $LOCALTIME ]; then' >> /etc/services.sh && \
  	echo 'rm $LOCALTIME' >> /etc/services.sh && \
  	echo 'ln -s /usr/share/zoneinfo/Asia/Tokyo $LOCALTIME' >> /etc/services.sh && \
	echo 'fi' >> /etc/services.sh && \
	touch /root/start.sh && \
	chmod +x /root/start.sh && \
	touch /root/crontab.txt && \
	echo '* * * * * /root/start.sh 2>&1 1>/dev/null' >> /root/crontab.txt && \
	echo 'crontab /root/crontab.txt' >> /etc/services.sh && \
	echo '/etc/init.d/crond start' >> /etc/services.sh && \
	echo '/usr/bin/tail -f /dev/null' >> /etc/services.sh && \
	touch /root/execme1st.sh && \
	echo '#!/bin/bash' >> /root/execme1st.sh && \
	chmod +x /etc/services.sh && \
	chmod +x /root/execme1st.sh && \
	yum update -y && \
	yum install -y vim wget which git curl tar zip unzip bzip2 make gcc-c++ zlib-devel crontabs && \
	yum install -y wget openssl openssl-devel
ENTRYPOINT /etc/services.sh

