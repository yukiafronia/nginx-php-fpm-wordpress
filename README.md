# nginx+php-fpm+wordpress with CentOS8
文教大学　null2x ベースwebサーバー スクリプト

仮想マシンはvirtualbox VMware Hyper-Vお好きなものをお使いください。  

# CentOS8.0 install手順
`http://ftp.jaist.ac.jp/pub/Linux/CentOS/8/isos/x86_64/CentOS-8-x86_64-DVD-1909.iso`  
`https://www.server-world.info/query?os=CentOS_8&p=install`  
`上記サイトを参考に、インストールを願います。GUIが良い方はソフトウェアの選択でGUIを選んでください`  

# Ansible構築　手順
`1.dnf -y install ansible`  
`2.cd /etc/ansible`  
`3.git clone https://github.com/yukiafronia/school-festival-SSH-Key.git`  
`4.wordpress-nginx_rhel7内のhosts内容を変更する。変更内容はIPアドレス`  
`5.cd /etc/ansible/wordpress-nginx_rhel8`  
`6.ansible-playbook -i hosts -u root --ask-pass site.yml`  
