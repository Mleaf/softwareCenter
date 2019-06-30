#!/bin/sh
#by mleaf
#kpr项目地址:https://github.com/user1121114685/koolproxyR/
#kpr规则更新地址:https://raw.githubusercontent.com/user1121114685/koolproxyR/master/koolproxyR/koolproxyR/data/rules
eval `dbus export koolproxy`
alias echo_date='echo 【$(TZ=UTC-8 date -R +%Y年%m月%d日\ %X)】:'
main_url="https://raw.githubusercontent.com/user1121114685/koolproxyR/master/koolproxyR/koolproxyR/data/rules"
kpr_restart=0

rm -rf /tmp/kpr
mkdir -p /tmp/kpr

download_rules(){
	echo_date 开始下载规则
	wget --no-check-certificate --timeout=10 -O /tmp/kpr/easylistchina.txt "$main_url"/easylistchina.txt
	wget --no-check-certificate --timeout=10 -O /tmp/kpr/fanboy-annoyance.txt "$main_url"/fanboy-annoyance.txt
	wget --no-check-certificate --timeout=10 -O /tmp/kpr/kp.dat "$main_url"/kp.dat
	wget --no-check-certificate --timeout=10 -O /tmp/kpr/kpr_video_list.txt "$main_url"/kpr_video_list.txt
	wget --no-check-certificate --timeout=10 -O /tmp/kpr/yhosts.txt         "$main_url"/yhosts.txt
	echo_date 规则下载完成
}

download_rules_md5(){
	echo_date 开始下载文件MD5
	wget --no-check-certificate --timeout=10 -O /tmp/kpr/easylistchina.txt.md5 "$main_url"/easylistchina.txt.md5
	wget --no-check-certificate --timeout=10 -O /tmp/kpr/fanboy-annoyance.txt.md5 "$main_url"/fanboy-annoyance.txt.md5
	wget --no-check-certificate --timeout=10 -O /tmp/kpr/kp.dat.md5 "$main_url"/kp.dat.md5
	wget --no-check-certificate --timeout=10 -O /tmp/kpr/kpr_video_list.txt.md5 "$main_url"/kpr_video_list.txt.md5
	wget --no-check-certificate --timeout=10 -O /tmp/kpr/yhosts.txt.md5         "$main_url"/yhosts.txt.md5
	wget --no-check-certificate --timeout=10 -O /tmp/kpr/kpr_our_rule.txt.md5        "$main_url"/kpr_our_rule.txt.md5
	echo_date 文件MD5下载完成
}

update_easylistchina(){
	wget --no-check-certificate --timeout=10 -O /tmp/kpr/easylistchina.txt.md5 "$main_url"/easylistchina.txt.md5
	web_easylistchina_md5=`cat /tmp/kpr/easylistchina.txt.md5`
	md5sum_easylistchina_jffs=`md5sum /jffs/softcenter/koolproxy/data/rules/easylistchina.txt | sed 's/ /\n/g'| sed -n 1p`
	if [ "$md5sum_easylistchina_jffs" != "$web_easylistchina_md5" ]; then
		echo_date easylistchina.txt 有新规则开始更新...
		wget --no-check-certificate --timeout=10 -O /tmp/kpr/easylistchina.txt "$main_url"/easylistchina.txt
		md5sum_easylistchina=`md5sum /tmp/kpr/easylistchina.txt | sed 's/ /\n/g'| sed -n 1p`
		if [ "$md5sum_easylistchina" != "$web_easylistchina_md5" ]; then
			echo_date easylistchina.txt更新包md5校验不一致！估计是下载的时候出了什么状况，请等待一会儿再试...
		else
			echo_date easylistchina.txt更新包md5校验一致！ 开始安装！...
			kpr_restart=1
			cp -f /tmp/kpr/easylistchina.txt /jffs/softcenter/koolproxy/data/rules/

		fi
	else
		echo_date easylistchina.txt规则已是最新无需更新！
	fi
}

update_fanboy_annoyance(){
	wget --no-check-certificate --timeout=10 -O /tmp/kpr/fanboy-annoyance.txt.md5 "$main_url"/fanboy-annoyance.txt.md5
	web_fanboy_annoyance_md5=`cat /tmp/kpr/fanboy-annoyance.txt.md5`
	md5sum_fanboy_annoyance_jffs=`md5sum /jffs/softcenter/koolproxy/data/rules/fanboy-annoyance.txt | sed 's/ /\n/g'| sed -n 1p`
	if [ "$md5sum_fanboy_annoyance_jffs" != "$web_fanboy_annoyance_md5" ]; then
		echo_date fanboy-annoyance.txt 有新规则开始更新...
		wget --no-check-certificate --timeout=10 -O /tmp/kpr/fanboy-annoyance.txt "$main_url"/fanboy-annoyance.txt
		md5sum_fanboy_annoyance=`md5sum /tmp/kpr/fanboy-annoyance.txt | sed 's/ /\n/g'| sed -n 1p`
		if [ "$md5sum_fanboy_annoyance" != "$web_fanboy_annoyance_md5" ]; then
			echo_date fanboy-annoyance.txt更新包md5校验不一致！估计是下载的时候出了什么状况，请等待一会儿再试...
		else
			echo_date fanboy-annoyance.txt更新包md5校验一致！ 开始安装！...
			kpr_restart=1
			cp -f /tmp/kpr/fanboy-annoyance.txt /jffs/softcenter/koolproxy/data/rules/
		fi
	else
		echo_date fanboy-annoyance.txt规则已是最新无需更新！
	fi
}

update_kp_dat(){
	wget --no-check-certificate --timeout=10 -O /tmp/kpr/kp.dat.md5 "$main_url"/kp.dat.md5
	web_kp_md5=`cat /tmp/kpr/kp.dat.md5`
	md5sum_kp_jffs=`md5sum /jffs/softcenter/koolproxy/data/rules/kp.dat | sed 's/ /\n/g'| sed -n 1p`
	if [ "$md5sum_kp_jffs" != "$web_kp_md5" ]; then
		echo_date kp.dat 有新规则开始更新...
		wget --no-check-certificate --timeout=10 -O /tmp/kpr/kp.dat "$main_url"/kp.dat
		md5sum_kp=`md5sum /tmp/kpr/kp.dat | sed 's/ /\n/g'| sed -n 1p`
		if [ "$md5sum_kp" != "$web_kp_md5" ]; then
			echo_date kp.dat更新包md5校验不一致！估计是下载的时候出了什么状况，请等待一会儿再试...
		else
			echo_date kp.dat更新包md5校验一致！ 开始安装！...
			kpr_restart=1
			cp -f /tmp/kpr/kp.dat /jffs/softcenter/koolproxy/data/rules/

		fi
	else
		echo_date kp.dat规则已是最新无需更新！
	fi
}

update_kpr_video_list(){
	wget --no-check-certificate --timeout=10 -O /tmp/kpr/kpr_video_list.txt.md5 "$main_url"/kpr_video_list.txt.md5
	web_kpr_video_list_md5=`cat /tmp/kpr/kpr_video_list.txt.md5`
	md5sum_kpr_video_list_jffs=`md5sum /jffs/softcenter/koolproxy/data/rules/kpr_video_list.txt | sed 's/ /\n/g'| sed -n 1p`
	if [ "$md5sum_kpr_video_list_jffs" != "$web_kpr_video_list_md5" ]; then
		echo_date kpr_video_list.txt 有新规则开始更新...
		wget --no-check-certificate --timeout=10 -O /tmp/kpr/kpr_video_list.txt "$main_url"/kpr_video_list.txt
		md5sum_kpr_video_list=`md5sum /tmp/kpr/kpr_video_list.txt | sed 's/ /\n/g'| sed -n 1p`
		if [ "$md5sum_kpr_video_list" != "$web_kpr_video_list_md5" ]; then
			echo_date kpr_video_list.txt更新包md5校验不一致！估计是下载的时候出了什么状况，请等待一会儿再试...
		else
			echo_date kpr_video_list.txt更新包md5校验一致！ 开始安装！...
			kpr_restart=1
			cp -f /tmp/kpr/kpr_video_list.txt /jffs/softcenter/koolproxy/data/rules/
		fi
	else
		echo_date kpr_video_list.txt规则已是最新无需更新！
	fi
}

update_yhosts(){
	wget --no-check-certificate --timeout=10 -O /tmp/kpr/yhosts.txt.md5         "$main_url"/yhosts.txt.md5
	web_yhosts_md5=`cat /tmp/kpr/yhosts.txt.md5`
	md5sum_yhosts_jffs=`md5sum /jffs/softcenter/koolproxy/data/rules/yhosts.txt | sed 's/ /\n/g'| sed -n 1p`
	if [ "$md5sum_yhosts_jffs" != "$web_yhosts_md5" ]; then
		wget --no-check-certificate --timeout=10 -O /tmp/kpr/yhosts.txt "$main_url"/yhosts.txt
		md5sum_yhosts=`md5sum /tmp/kpr/yhosts.txt | sed 's/ /\n/g'| sed -n 1p`
		if [ "$md5sum_yhosts" != "$web_yhosts_md5" ]; then
			echo_date yhosts.txt更新包md5校验不一致！估计是下载的时候出了什么状况，请等待一会儿再试...
		else
			echo_date yhosts.txt更新包md5校验一致！ 开始安装！...
			kpr_restart=1
			cp -f /tmp/kpr/yhosts.txt /jffs/softcenter/koolproxy/data/rules/
		fi
	else
		echo_date yhosts.txt规则已是最新无需更新！
	fi
}


update_rules(){
	echo_date 更新过程中请不要刷新本页面或者关闭路由等，不然可能导致问题！
	echo_date 检测kpr主服务器在线规则...
	update_easylistchina
	update_fanboy_annoyance
	update_kp_dat
	update_kpr_video_list
	update_yhosts

	rm -rf /tmp/kpr
	
	if [ "$kpr_restart" == "1" ];then
		echo_date 重启kpr进程...
		sh /jffs/softcenter/scripts/koolproxy_config.sh
	fi
}

update_rules
