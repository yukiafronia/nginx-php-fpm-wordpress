# school-festival
文教大学　学祭　null2x Web制作

# Ansible構築　手順
1.yum -y install ansible
2.git clone 
3.wordpress-nginx_rhel7内のhosts内容を変更する。変更内容はIPアドレス
4.ansible-playbook -i hosts -u root --ask-pass site.yml
