# nginx+php-fpm+wordpress with CentOS8
文教大学　null2x ベースwebサーバー スクリプト

仮想マシンはvirtualbox VMware Hyper-Vお好きなものをお使いください。  

# CentOS8.0 install手順
`http://ftp.jaist.ac.jp/pub/Linux/CentOS/8/isos/x86_64/CentOS-8-x86_64-DVD-1909.iso`  
`https://www.server-world.info/query?os=CentOS_8&p=install`  
`上記サイトを参考に、インストールを願います。GUIが良い方はソフトウェアの選択でGUIを選んでください`  

# Ansible構築　手順
`1.pip3 install ansible`  
`2.cd /root`  
`3.git clone https://github.com/yukiafronia/nginx-php-fpm-wordpress.git`  
`4.wordpress-nginx_rhel8内のhosts内容を変更する。変更内容はIPアドレス`  
`5.cd /root/ansible/nginx-php-fpm-wordpress/wordpress-nginx_rhel8`  
`6.ansible-playbook -i hosts -u root --ask-pass site.yml`  

## 現在の進捗  

2019/09/28 現在

![CentOS8 (Ansible)-2019-09-28-19-46-20](https://user-images.githubusercontent.com/23439178/65815419-c2480580-e1de-11e9-86de-82f430ab072a.png)  

- MariaDBへのデータベース作成の際、MariaDBのログイン情報が渡されずデータベースの作成まで至らない。  
- ansible側でplaybook実行の際、sshのパスワード認証の為sshpass.rpmが足りず怒られるので導入の際忘れずに。  

2019/11/02 現在  
MariaDB における create database とデータベースのアクセスユーザ、パスワード設定をcommand module利用によりワンライナーで完結させることに成功  

解決策  
mysql -u root -e SQL文 の構文がコマンドで通るはずだったのだが、文法が間違っていたため今まで実装することが出来なかった。  
Ansibleでのmoduleでデータベースを作る方法は依然として資格情報が渡されないため、冪等性を確保できなくなってしまっているがcommand module でコマンド実施済みかどうかを判定出来るようにしていきたい（あくまで理想です 笑)  