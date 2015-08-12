# FirewallD is a pain to just remove it
ensure_packages('firewalld', { ensure => absent })

node 'db.vagrant.herqles.io' {

  # Install PostgreSQL
  include ::postgresql::globals
  include ::postgresql::client
  include ::postgresql::lib::devel
  include ::postgresql::server

  Class['::postgresql::globals']
  -> Class['::postgresql::client']
  -> Class['::postgresql::server']
  -> Class['::postgresql::lib::devel']

  # Setup the herqles database
  postgresql::server::db { 'herqles':
    user     => 'herqles',
    password => postgresql_password('herqles', 'herqles')
  }

  # Install Erlang
  include ::epel
  ensure_packages('erlang', { require => Class['epel'] })

  #Install RabbitMQ
  include ::rabbitmq

  Package['erlang']
  -> Class['::rabbitmq']

  # Create an admin user
  rabbitmq_user { 'admin':
    admin    => true,
    password => 'admin'
  }
  # Create the herqles user
  rabbitmq_user { 'herqles':
     password => 'herqles'
  }
  # Create the herqles vhost
  rabbitmq_vhost { 'herqles':
    ensure => present
  }
  # Allow admin to use / (this is needed for the management interface)
  rabbitmq_user_permissions { 'admin@/':
    configure_permission => '.*',
    read_permission      => '.*',
    write_permission     => '.*',
  }
  # Allow admin to use herqles
  rabbitmq_user_permissions { 'admin@herqles':
    configure_permission => '.*',
    read_permission      => '.*',
    write_permission     => '.*',
  }
  # Allow herqles to user herqles
  rabbitmq_user_permissions { 'herqles@herqles':
    configure_permission => '.*',
    read_permission      => '.*',
    write_permission     => '.*',
  }
}