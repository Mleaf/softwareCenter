#! /bin/sh
eval `dbus export koolproxy`
source /jffs/softcenter/scripts/base.sh

case $ACTION in
start)
	sh /jffs/softcenter/koolproxy/kp_update.sh
	;;
*)
	sh /jffs/softcenter/koolproxy/kp_update.sh  > /tmp/koolproxy_run.log
	echo XU6J03M6 >> /tmp/koolproxy_run.log
	sleep 2
	rm -rf /tmp/koolproxy_run.log
	;;
esac
