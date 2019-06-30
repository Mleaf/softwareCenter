#!/bin/sh

eval `dbus export koolproxy`
alias echo_date='echo 【$(TZ=UTC-8 date -R +%Y年%m月%d日\ %X)】:'
main_url="http://www.mleaf.org/downloads/sbr-ac1200p/software/koolproxy"
backup_url=""
rm -rf /tmp/koolproxy
install_kpr(){
	echo_date 开始解压压缩包...
	tar -zxf koolproxy.tar.gz
	chmod a+x /tmp/koolproxy/install.sh
	echo_date 开始安装更新文件...
	sh /tmp/koolproxy/install.sh
	echo_date 开始完成...
	rm -rf /tmp/koolproxy
	rm -rf /tmp/koolproxy.tar.gz
}

update_kpr(){
	echo_date 更新过程中请不要刷新本页面或者关闭路由等，不然可能导致问题！
	echo_date 开启SS检查更新：使用主服务器：github
	echo_date 检测主服务器在线版本号...
	koolproxy_version_web1=`curl --connect-timeout 5 -s "$main_url"/version | sed -n 1p`
	if [ -n "$koolproxy_version_web1" ];then
		echo_date 检测到主服务器在线版本号：$koolproxy_version_web1
		dbus set koolproxy_version_web=$koolproxy_version_web1
		if [ "$koolproxy_version" != "$koolproxy_version_web1" ];then
		echo_date 主服务器在线版本号："$koolproxy_version_web1" 和本地版本号："$koolproxy_version" 不同！
			cd /tmp
			md5_web1=`curl -s "$main_url"/version | sed -n 2p`
			echo_date 开启下载进程，从主服务器上下载更新包...
			rm -rf /tmp/koolproxy.tar.gz
			rm -rf /tmp/koolproxy
			wget --no-check-certificate --timeout=5 "$main_url"/koolproxy.tar.gz
			md5sum_gz=`md5sum /tmp/koolproxy.tar.gz | sed 's/ /\n/g'| sed -n 1p`
			if [ "$md5sum_gz" != "$md5_web1" ]; then
				echo_date 更新包md5校验不一致！估计是下载的时候出了什么状况，请等待一会儿再试...
				rm -rf /tmp/koolproxy* >/dev/null 2>&1
				sleep 1
				echo_date 更换备用备用更新地址，请稍后...
				sleep 1
				update_kpr2
			else
				echo_date 更新包md5校验一致！ 开始安装！...
				install_kpr
			fi
		else
			echo_date 主服务器在线版本号："$ss_basic_version_web1" 和本地版本号："$koolproxy_version" 相同！
			echo_date 退出插件更新!
			sleep 1
			exit
		fi
	else
		echo_date 没有检测到主服务器在线版本号,访问github服务器可能有点问题！
		sleep 1
		echo_date 更换备用备用更新地址，请稍后...
		sleep 1
		update_ss2
	fi
}

update_kpr2(){
	echo_date "目前还没有任何备用服务器！请尝试使用离线安装功能！"
	echo_date "历史版本下载地址：https://github.com/paldier/softcenter/tree/master/shadowsocks/history"
	echo_date "下载后请将下载包名字改为：shadowsocks.tar.gz，再使用离线安装进行安装"
	sleep 1
	exit
}

update_kpr
