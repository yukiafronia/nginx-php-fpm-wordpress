#!/bin/bash
echo ""
echo "---------------------------------------------------------------------------------------------------------------------------"
echo ""
echo "# これは、起動毎に実行されるスクリプトです。"
echo "# 主に、Linux Kernelのバージョンアップ及び登録されているライブラリ、リポジトリのパッケージアップデートを自動で行うためのスクリプトです。"
echo "# 製作者 : Yuki Hiramastsu"
echo "# Ver 0.0.1 at 2019 09 25"
echo ""
sleep 4
# null2x web Server Scriptに統合の為SELinux , firewalldのdisabled設定は無効化
<< COMMENTOUT
echo "---------------------------------------------------------------------------------------------------------------------------"
echo "---------------------------------------------------------------------------------------------------------------------------"
echo ""
echo "# SELinux停止"
setenforce 0
cat /etc/sysconfig/selinux | sed -i -e "s/^SELINUX=enforcing$/SELINUX=disabled/g" /etc/selinux/config
echo ""
getenforce
echo ""
echo "なお、"Permissive"と表示されている場合は、SELinuxは有効だが、アクセス制限は行わず警告のみ出力となります。"
sleep 4
echo "---------------------------------------------------------------------------------------------------------------------------"
echo ""
echo "---------------------------------------------------------------------------------------------------------------------------"
echo "# Firewalld一旦停止"
systemctl stop firewalld
echo ""
systemctl status firewalld
echo ""
#Firewalld 永続停止
echo "# Firewalld永続停止"
systemctl disable firewalld
echo ""
sleep 4
COMMENTOUT
echo "---------------------------------------------------------------------------------------------------------------------------"
echo ""
echo "---------------------------------------------------------------------------------------------------------------------------"
echo ""
echo "# ELRepoの登録"
rpm -Uvh https://www.elrepo.org/elrepo-release-8.0-2.el8.elrepo.noarch.rpm
echo ""
echo "# ELRepo elrepo-kernelのenabled値を変更"
sed -i -e "35 s/enabled=0/enabled=1/g" /etc/yum.repos.d/elrepo.repo
echo ""
sed -n 28,38p /etc/yum.repos.d/elrepo.repo
echo "---------------------------------------------------------------------------------------------------------------------------"
echo ""
echo "# カーネルアップデート"
echo "# 現在のカーネルバージョンを確認"
uname -a
echo ""
echo ""
echo "# 本カーネルのアップデートと関連パッケージの切り替え"
echo ""
echo "# 最新安定版カーネルのインストール"
dnf --enablerepo=elrepo-kernel -y install kernel-ml
if [ $? == 100 ]; then
    shutdown -r now
else
    echo "Great stuff! No updates pending..."
fi

echo "# kernel-tools-libs 切り替え"
dnf --enablerepo=elrepo-kernel -y swap \kernel-tools-libs -- \kernel-ml-tools-libs

echo "# kernel-ml-tools 新規インストール"
dnf --enablerepo=elrepo-kernel -y install kernel-ml-tools

echo "利用したいカーネルを設定"
grub2-set-default 0

echo "利用するカーネルの優先順位リスト"
awk -F\' '$1=="menuentry " {print i++ " : " $2}' /etc/grub2.cfg

# echo "# 旧カーネルの本体削除"
dnf -y remove kernel

echo "全体パッケージのアップデート"
dnf -y update

if [ $? == 100 ]; then
    echo "アップデートがありませんでした。! "
else
    dnf -y remove kernel
    shutdown -r now
fi

echo ""
echo "---------------------------------------------------------------------------------------------------------------------------"
