# nginx+php-fpm+wordpress with CentOS8
文教大学　null2x ベースwebサーバー スクリプト

仮想マシンはvirtualbox VMware Hyper-Vお好きなものをお使いください。  

# CentOS8.0 install手順
`http://ftp.jaist.ac.jp/pub/Linux/CentOS/8/isos/x86_64/CentOS-8-x86_64-DVD-1909.iso`  
`https://www.server-world.info/query?os=CentOS_8&p=install`  
`上記サイトを参考に、インストールを願います。GUIが良い方はソフトウェアの選択でGUIを選んでください`  

# Ansible構築　手順
`1.dnf -y install python3-pip`  

`2.pip3 install ansible`  


```bash
[root@localhost ~]# pip3 install ansible
WARNING: Running pip install with root privileges is generally not a good idea. Try `pip3 install --user` instead.
Collecting ansible
  Downloading https://files.pythonhosted.org/packages/03/4f/cccab1ec2e0ecb05120184088e00404b38854809cf35aa76889406fbcbad/ansible-2.9.10.tar.gz (14.2MB)
    100% |████████████████████████████████| 14.2MB 72kB/s
Collecting jinja2 (from ansible)
  Downloading https://files.pythonhosted.org/packages/30/9e/f663a2aa66a09d838042ae1a2c5659828bb9b41ea3a6efa20a20fd92b121/Jinja2-2.11.2-py2.py3-none-any.whl (125kB)
    100% |████████████████████████████████| 133kB 4.3MB/s
Collecting PyYAML (from ansible)
  Downloading https://files.pythonhosted.org/packages/64/c2/b80047c7ac2478f9501676c988a5411ed5572f35d1beff9cae07d321512c/PyYAML-5.3.1.tar.gz (269kB)
    100% |████████████████████████████████| 276kB 3.0MB/s
Requirement already satisfied: cryptography in /usr/lib64/python3.6/site-packages (from ansible)
Collecting MarkupSafe>=0.23 (from jinja2->ansible)
  Downloading https://files.pythonhosted.org/packages/b2/5f/23e0023be6bb885d00ffbefad2942bc51a620328ee910f64abe5a8d18dd1/MarkupSafe-1.1.1-cp36-cp36m-manylinux1_x86_64.whl
Requirement already satisfied: idna>=2.1 in /usr/lib/python3.6/site-packages (from cryptography->ansible)
Requirement already satisfied: asn1crypto>=0.21.0 in /usr/lib/python3.6/site-packages (from cryptography->ansible)
Requirement already satisfied: six>=1.4.1 in /usr/lib/python3.6/site-packages (from cryptography->ansible)
Requirement already satisfied: cffi!=1.11.3,>=1.7 in /usr/lib64/python3.6/site-packages (from cryptography->ansible)
Requirement already satisfied: pycparser in /usr/lib/python3.6/site-packages (from cffi!=1.11.3,>=1.7->cryptography->ansible)
Installing collected packages: MarkupSafe, jinja2, PyYAML, ansible
  Running setup.py install for PyYAML ... done
  Running setup.py install for ansible ... done
Successfully installed MarkupSafe-1.1.1 PyYAML-5.3.1 ansible-2.9.10 jinja2-2.11.2
```

`3.cd /root`  

`4.dnf -y install 	https://download-ib01.fedoraproject.org/pub/epel/8/Everything/x86_64/Packages/s/sshpass-1.06-9.el8.x86_64.rpm`  

`5.dnf -y install git`  

`6.git clone https://github.com/yukiafronia/nginx-php-fpm-wordpress.git`  

`7.wordpress-nginx_rhel8内のhosts内容を変更する。変更内容はIPアドレス`  

`8.cd /root/ansible/nginx-php-fpm-wordpress/wordpress-nginx_rhel8`  

`9.ansible-playbook -i hosts -u root --ask-pass site.yml`  

## 現在の進捗  

2019/09/28 現在

![CentOS8 (Ansible)-2019-09-28-19-46-20](https://user-images.githubusercontent.com/23439178/65815419-c2480580-e1de-11e9-86de-82f430ab072a.png)  

- MariaDBへのデータベース作成の際、MariaDBのログイン情報が渡されずデータベースの作成まで至らない。  
- ansible側でplaybook実行の際、sshのパスワード認証の為sshpass.rpmが足りず怒られるので導入の際忘れずに。  

※sshpass.rpmについて  (2020/07/04 現在)  
MarkdownのREADMEにsshpass.rpmをdnf installでインストールするよう手順を加えました。  
rpmでのインストールになるので出来る限りこまめにアップデートを行っていく予定です。

2019/11/02 現在  
MariaDB における create database とデータベースのアクセスユーザ、パスワード設定をcommand module利用によりワンライナーで完結させることに成功  

![ansible(CentOS8 wordpress)](https://user-images.githubusercontent.com/23439178/67970060-40defb00-fc02-11e9-8803-502c667ef1d2.gif)

解決策  
mysql -u root -e SQL文 の構文がコマンドで通るはずだったのだが、文法が間違っていたため今まで実装することが出来なかった。  
Ansibleでのmoduleでデータベースを作る方法は依然として資格情報が渡されないため、冪等性を確保できなくなってしまっているがcommand module でコマンド実施済みかどうかを判定出来るようにしていきたい（あくまで理想です 笑)  

2020/07/04 現在  
MariaDB 10.4 -> 10.5 へのリポジトリアップデート  
Wordpress 5.4.2 へのアップデート  
READMEの記述内容変更  

MariaDB credential error 発生  

![image](https://user-images.githubusercontent.com/23439178/86516610-072f5580-be5d-11ea-9165-027c29ec2456.png)