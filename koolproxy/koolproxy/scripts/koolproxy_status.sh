#!/bin/sh

alias echo_date1='echo $(date +%Y年%m月%d日\ %X)'
export KSROOT=/jffs/softcenter
source $KSROOT/scripts/base.sh
eval `dbus export koolproxy_`

version="koolproxy `koolproxy -v`"
status=`ps|grep -w koolproxy | grep -cv grep`
pid=`pidof koolproxy`
date=`echo_date1`

rules_date_local=`cat $KSROOT/koolproxy/data/rules/koolproxy.txt  | sed -n '3p'|awk '{print $3,$4}'`
rules_nu_local=`grep -E -v "^!" $KSROOT/koolproxy/data/rules/koolproxy.txt | wc -l`
video_date_local=`cat $KSROOT/koolproxy/data/rules/koolproxy.txt  | sed -n '4p'|awk '{print $3,$4}'`
daily_nu_local=`grep -E -v "^!" $KSROOT/koolproxy/data/rules/daily.txt | wc -l`
#custom_nu_local=`grep -E -v "^!" $KSROOT/koolproxy/data/rules/user.txt | wc -l`

easylistchina_date_local=`cat $KSROOT/koolproxy/data/rules/easylistchina.txt  | sed -n '3p'|awk '{print $3,$4}'`
easylistchina_nu_local=`grep -E -v "^!" $KSROOT/koolproxy/data/rules/easylistchina.txt | wc -l`

fanboy_annoyance_date_local=`cat $KSROOT/koolproxy/data/rules/fanboy-annoyance.txt  | sed -n '3p'|awk '{print $3,$4}'`
fanboy_annoyance_nu_local=`grep -E -v "^!" $KSROOT/koolproxy/data/rules/fanboy-annoyance.txt | wc -l`
kpr_video_list_nu_local=`grep -E -v "^!" $KSROOT/koolproxy/data/rules/kpr_video_list.txt | wc -l`

yhosts_date_local=`cat /jffs/softcenter/koolproxy/data/rules/yhosts.txt | sed -n '2p'|cut -d = -f2`
yhosts_list_nu_local=`grep -E -v "^!" $KSROOT/koolproxy/data/rules/yhosts.txt | wc -l`

rm -rf /tmp/kp_tp.txt
tp_rules=`dbus list koolproxy_rule_file_|cut -d "=" -f1|cut -d "_" -f4|sort -n`
i=1
for tp_rule in $tp_rules
do
	tprule_name=`dbus get koolproxy_rule_file_$tp_rule`
	if [ -f "$KSROOT/koolproxy/data/rules/$tprule_name" ]; then
		eval tprule_nu_$i=`grep -E -v "^!" $KSROOT/koolproxy/data/rules/$tprule_name | wc -l`
		eval temp=$(echo \$tprule_nu_$i)
		#echo $tp_rule $tprule_name $temp条
		echo -n "@@<span>$temp条</span>&&$tp_rule" >>/tmp/kp_tp.txt
		let i++
	else
		echo -n "@@<span>null</span>&&$tp_rule" >>/tmp/kp_tp.txt
	fi
done

if [ -f "/tmp/kp_tp.txt" ];then
	TP=`cat /tmp/kp_tp.txt`
else
	TP=""
fi
rm -rf /tmp/koolproxy.log
if [ "$status" == "2" ];then
	echo "【$date】 $version  运行正常！(PID: $pid)@@<span>$rules_date_local / $rules_nu_local条</span>@@<span>$daily_nu_local条</span>@@<span>$video_date_local<span>@@<span>$easylistchina_date_local / $easylistchina_nu_local条<span>@@<span>$fanboy_annoyance_date_local / $fanboy_annoyance_nu_local条<span>@@<span>$kpr_video_list_nu_local条<span>@@<span>$yhosts_date_local / $yhosts_list_nu_local条<span>$TP" > /tmp/koolproxy.log
else
	echo "<font color='#FF0000'>【警告】：进程未运行！请点击提交按钮！</font>@@<span>$rules_date_local / $rules_nu_local条</span>@@<span>$daily_nu_local条</span>@@<span>$video_date_local<span>@@<span>$easylistchina_nu_local条<span>@@<span>$fanboy_annoyance_nu_local条<span>@@<span>$kpr_video_list_nu_local条<span>@@<span>$yhosts_list_nu_local条<span>$TP" > /tmp/koolproxy.log
fi
echo XU6J03M6 >> /tmp/koolproxy.log

