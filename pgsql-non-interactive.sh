#Installation of PostgreSQL and SetUp
echo "Installing software prerequsites..."
sudo apt install wget ca-certificates -y
echo "DONE"
echo "----"
echo "  "
sleep 5

echo "Adding Key"
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
echo "DONE"
echo "----"
echo "  "
sleep 5

echo "Add PgSQL repo to sources list"
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
echo "DONE"
echo "----"
echo "  "
sleep 5

echo "Installing PostgreSQL"
sudo apt update -y && sudo apt upgrade -y && sudo apt install postgresql postgresql-contrib -y
echo "DONE"
echo "----"
echo "  "
sleep 5

#Setting Up PostgreSQL Server
echo "Allowing Remote Access...."
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" /etc/postgresql/15/main/postgresql.conf
echo "DONE"
echo "----"
echo "  "
sleep 5

echo "Allowing TCP/IP connections to all databases for all users with any IPV4 address using an MD5 password"
sudo sh -c 'echo "host    replication     all             0.0.0.0/0               md5" >> /etc/postgresql/15/main/pg_hba.conf'
echo "DONE"
echo "----"
echo "  "
sleep 5

echo "Allowing connections to all databases for all local users using an MD5 password"
sudo sed -i "s/local   all             all                                     peer/local   all             all                                     md5/" /etc/postgresql/15/main/pg_hba.conf
echo "DONE"
echo "----"
echo "  "
sleep 5

echo "Allowing connections to all databases for all default user postgres without password"
sudo sed -i "s/local   all             postgres                                peer/local   all             postgres                                trust/" /etc/postgresql/15/main/pg_hba.conf
echo "DONE"
echo "----"
echo "  "
sleep 5

#Restart PostgreSQL
echo "Restarting PostgreSQL Service to reload configurations...."
sudo systemctl restart postgresql
echo "DONE"
echo "----"
echo "  "
sleep 5

#Setting Up New User for PostgreSQL
echo "Creating New User in PostgreSQL with username Seyi..."
sleep 5
#echo "Enter Username: "
#read User
sudo -u postgres createuser -s Seyi
echo "DONE"
echo "----"
echo "  "
sleep 5


#Setting Up New Database
echo "Creating New Database in PostgreSQL with name ExampleDB..."
sleep 5
sudo createdb -U postgres ExampleDB
echo "DONE"
echo "----"
echo "  "
