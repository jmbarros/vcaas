#!/bin/bash
###################
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
######################

#pre-reqs
#########################
sudo apt-get -y install git
sudo apt-get -y install python-pip
sudo pip install --upgrade pip
sudo apt-get -y install libmysqlclient-dev
sudo apt-get -y install build-essential autoconf libtool pkg-config python-opengl python-imaging python-pyrex python-pyside.qtopengl idle-python2.7 qt4-dev-tools qt4-designer libqtgui4 libqtcore4 libqt4-xml libqt4-test libqt4-script libqt4-network libqt4-dbus python-qt4 python-qt4-gl libgle3 python-dev
sudo apt-get -y install rabbitmq-server
sudo apt-get -y install python-celery-common


#mysql
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password 123mudar'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password 123mudar'
sudo apt-get -y install mysql-server
sudo mysql -u root -p123mudar -e "CREATE DATABASE vmware;"
sudo mysql -u root -p123mudar -e "CREATE USER 'vmware'@'localhost' IDENTIFIED BY 'IBM_2016';"
sudo mysql -u root -p123mudar -e "GRANT ALL PRIVILEGES ON vmware.* TO 'vmware'@'localhost';"
sudo mysql -u vmware -pIBM_2016 -e "SOURCE /root/VMware-automation-v2/vmware_schema_db.sql;" vmware

#clone
git clone git@github.ibm.com:jmbarros/vmware-production-bmx.git

#python
sudo pip install -r /root/vmware-production-bmx/esxi/requirements.txt
sudo pip install -r /root/vmware-production-bmx/lun/requirements.txt
sudo pip install -r /root/vmware-production-bmx/lun_permissions/requirements.txt
#sudo pip install -r /root/vmware-production-bmx/softlayer/requirements.txt
sudo pip install -r /root/vmware-production-bmx/ticket/requirements.txt
sudo pip install -r /root/vmware-production-bmx/vyatta/requirements.txt
sudo pip install -r /root/vmware-production-bmx/vyatta_conf/requirements.txt
sudo pip install -r /root/vmware-production-bmx/web/requirements.txt
