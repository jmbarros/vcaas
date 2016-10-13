#!/bin/bash
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

export VCAP_SERVICES='{"cleardb":[{"credentials":{"hostname":"localhost","name":"vmware","password":"IBM_2016","port":"3306","username":"vmware"}}],"cloudamqp":[{"credentials":{"uri":"amqp://guest:guest@127.0.0.1:5672/"}}]}'

killall -9 python
#Destroy database if it exists
sudo mysql -u root -p123mudar -e "DROP DATABASE vmware;"
#Create database
sudo mysql -u root -p123mudar -e "CREATE DATABASE vmware;"
sudo mysql -u root -p123mudar -e "CREATE USER 'vmware'@'localhost' IDENTIFIED BY 'IBM_2016';"
sudo mysql -u root -p123mudar -e "GRANT ALL PRIVILEGES ON vmware.* TO 'vmware'@'localhost';"
sudo mysql -u vmware -pIBM_2016 -e "SOURCE ~/vmware-production-bmx/vmware_schema.sql;" vmware

echo executing: /root/vmware-production-bmx/esxi/esxi_provision.py
PORT=15001 python /root/vmware-production-bmx/esxi/esxi_provision.py &> /root/vmware-production-bmx/esxi_provision_exec.log &

echo executing: /root/vmware-production-bmx/vyatta/vyatta_provision.py
PORT=15002 python /root/vmware-production-bmx/vyatta/vyatta_provision.py &> /root/vmware-production-bmx/vyatta_provision_exec.log &

echo executing: /root/vmware-production-bmx/vyatta_conf/vyatta_conf.py
PORT=15003 python /root/vmware-production-bmx/vyatta_conf/vyatta_conf.py &> /root/vmware-production-bmx/vyatta_conf_exec.log &

echo executing: /root/vmware-production-bmx/lun/create_lun.py
PORT=15004 python /root/vmware-production-bmx/lun/create_lun.py &> /root/vmware-production-bmx/lun_create_exec.log &

echo executing: /root/vmware-production-bmx/lun-permissions/permissions_lun.py
PORT=15005 python /root/vmware-production-bmx/lun_permissions/permissions_lun.py &> /root/vmware-production-bmx/lun_permissions_exec.log &

echo executing: /root/vmware-production-bmx/ticket/ticket.py
PORT=15006 python /root/vmware-production-bmx/ticket/ticket.py &> /root/vmware-production-bmx/ticket_exec.log &