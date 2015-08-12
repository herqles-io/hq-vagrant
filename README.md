# Herqles Vagrant

Quickly setup a Herqles environment for development and other testing.

## How to use

1. Install librarian-puppet

```
gem install librarian-puppet
```

2. Clone the repo

```
git clone https://github.com/herqles-io/hq-vagrant.git
cd hq-vagrant
```

3. Install all the Puppet modules

```
cd puppet/environments/vagrant
librarian-puppet install
cd ../../..
```

4. Run Vagrant

```
vagrant up
```

You can now access the RabbitMQ managerment interface by going to http://192.168.33.10:15672 using the username and
password of admin

The Herqles admin username and password is admin, the manager api's can be accessed at http://192.168.33.11/manager, and 
the framework api's can be accessed at http://192.168.33.11/frameworks

## TODO
 
Use a vagrant.yaml for ease of configuration
Multi-Datacenter testing
RabbitMQ Clustering
Multiple Manager and Framework VMs
Multiple Worker VMs