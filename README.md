# Vagrant Postgres cluster

Deploys a postgres cluster with 2 servers, one master and one slave.
Creates a Vagrant environment running PostgreSQL 10 Hot Standby Streaming Replication (Master/Slave).

### Tools deployed
* postgres

Tools used in preparation
* Vagrant
* Virtualbox


### How to run:

Clone the project
```
git clone https://github.com/echatzig/vagrant-postgres-master-detail
```
 
Go to the folder that you just checkout and run the following commands:
```
mkdir .ssh
chmod 700 .ssh
ssh-keygen -f .ssh/id_rsa 
```
To make things easy ignore the passphrase

and finally run
```
vagrant up
```

### Notes

In the master dir, we have the config file (postgresql.conf) and pg_hba.conf.
The slave does not need them, as it will get them from the master when we start it as slave.

### To verify

vagrant ssh pgmaster
   sudo -u postgres psql -d postgres -c "create database sampledb;"
   sudo -u postgres psql -d sampledb -c "create table tab (val int); insert into tab values (42);"
 
vagrant ssh pgslave 
	sudo -u postgres psql -d sampledb -c "select * from tab;"
	
	