#!/bin/sh
USER=typista
if [ "$1" = "" ];then
	echo "Input parametor FQDN [and TAG]"
else
	__FQDN__=$1
	__HOSTNAME__=`echo $__FQDN__ | sed -r "s/\./_/g"`
	FULLPATH=$(cd `dirname $0`; pwd)/`basename $0`
	DIR=`dirname $FULLPATH`
	REPO=`basename $DIR`
	REPO=`echo $REPO | sed -r "s/docker\-//g"`
	IMAGE=$USER/$REPO
	if [ "$2" != "" ];then
    		IMAGE=$IMAGE:$2
	fi
	docker run -d --privileged  --name="$__FQDN__" --hostname="$__HOSTNAME__" \
		-v ${PWD}/export/root/:/root/export/ \
		$IMAGE

	DIR_CONTAINER=dst/$__FQDN__
	if [ ! -e $DIR_CONTAINER ];then
		mkdir -p $DIR_CONTAINER
	fi

        BOOT=./container/docker-boot-$__HOSTNAME__.sh
        BOOT_OFF=./container/docker-boot-off-$__HOSTNAME__.sh
        REMOVE=./container/docker-remove-$__HOSTNAME__.sh
        echo "./docker-boot.sh $__FQDN__" > $BOOT
        echo "./docker-boot-off.sh $__FQDN__" > $BOOT_OFF
        echo "docker rm -f $__FQDN__" > $REMOVE
        echo "sudo rm -rf /var/www/$__HOSTNAME__" >> $REMOVE
        chmod +x $BOOT
        chmod +x $BOOT_OFF
        chmod +x $REMOVE
        $BOOT
fi
