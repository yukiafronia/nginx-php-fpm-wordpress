# nginx+php-fpm+wordpress with CentOS7.7
文教大学　null2x ベースwebサーバー スクリプト

仮想マシンはvirtualbox VMware Hyper-Vお好きなものをお使いください。

# システム構成  
2019 10/02 時点
- nginx 1.17.4  
- PHP7.4.0RC3  
- MariaDB 10.4.8  
- wordpress 5.2.3  
<br>  

# CentOS7.7 install手順
`http://ftp.jaist.ac.jp/pub/Linux/CentOS/7.7.1908/isos/x86_64/CentOS-7-x86_64-DVD-1908.iso`  
`https://www.server-world.info/query?os=CentOS_7&p=install`  
`上記サイトを参考に、インストールを願います。GUIが良い方はソフトウェアの選択でGUIを選んでください`  

# Ansible構築　手順
`1.yum -y install ansible`  
`2.cd /root/`  
`3.git clone https://github.com/yukiafronia/nginx-php-fpm-wordpress.git`  

`4.wordpress-nginx_rhel7内のhosts内容を変更する。変更内容はIPアドレス`

![image](https://user-images.githubusercontent.com/23439178/66048811-bf6c4e00-e519-11e9-9fa2-69d01e91473e.png)

`5.cd /root/wordpress-nginx_rhel7`  
`6.ssh root@192.168.1.10`  

![image](https://user-images.githubusercontent.com/23439178/66049260-a31ce100-e51a-11e9-9479-b7b6fd4697cb.png)

`7.ansible-playbook -i hosts -u root --ask-pass site.yml`  

![image](https://user-images.githubusercontent.com/23439178/66049760-859c4700-e51b-11e9-90ee-46c4776f04c4.png)  
<br>  

![image](https://user-images.githubusercontent.com/23439178/66049805-9a78da80-e51b-11e9-954e-7fecdccd18b9.png)  

<br>  

`8. 最後にwordpressを導入したIPアドレスにwebブラウザでアクセスして、管理者権限で画面に入りましょう。`  

![image](https://user-images.githubusercontent.com/23439178/66049942-d6ac3b00-e51b-11e9-995b-021ba2f96a54.png)  


以上です。大変お疲れさまでした。！