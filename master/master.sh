#!/usr/bin/env bash
mkdir -p /home/vagrant/.ssh
cp /vagrant/.ssh/* /home/vagrant/.ssh/
chmod 700 /home/vagrant/.ssh
chmod 600 /home/vagrant/.ssh/id_rsa
chmod 644 /home/vagrant/.ssh/id_rsa.pub

sudo chown vagrant:vagrant /home/vagrant/.ssh -R

cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
chmod 600 /home/vagrant/.ssh/authorized_keys

sudo echo "deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main" > /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update

sudo apt-get install -y postgresql-10
#postgresql10-contrib postgresql10-server

sudo -u postgres -H sh -c "psql -c 'CREATE USER rep REPLICATION LOGIN CONNECTION LIMIT 2;'"

sudo cp /vagrant/master/pg_hba.conf     /etc/postgresql/10/main/pg_hba.conf
sudo cp /vagrant/master/postgresql.conf /etc/postgresql/10/main/postgresql.conf

sudo chown postgres:postgres /etc/postgresql/10/main/pg_hba.conf
sudo chown postgres:postgres /etc/postgresql/10/main/postgresql.conf

sudo service postgresql restart