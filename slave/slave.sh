mkdir -p /home/vagrant/.ssh
cp /vagrant/.ssh/* /home/vagrant/.ssh/
chmod 700 /home/vagrant/.ssh
chmod 600 /home/vagrant/.ssh/id_rsa
chmod 644 /home/vagrant/.ssh/id_rsa.pub

sudo chown vagrant:vagrant /home/vagrant/.ssh -R

cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
chmod 600 /home/vagrant/.ssh/authorized_keys

PG_DATABASE_NAME="repl_database"

echo "Installing utils..."

sudo echo "deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main" > /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update

sudo apt-get install -y postgresql-10

service postgresql stop

sudo rm -fR /var/lib/postgresql/10/main/

pg_basebackup -h 192.168.1.120 -D /var/lib/postgresql/10/main/ -U rep -v -P --wal-method=stream -R

echo "trigger_file = '/tmp/postgresql.trigger.5432'" >> /var/lib/postgresql/10/main/recovery.conf

chown postgres:postgres -R /var/lib/postgresql/10/main/

sudo service postgresql start