class mysql::config::mysqld {
  mysql::config {
    'net_read_timeout':     value => '7200',
    'net_write_timeout':    value => '7200',
    'bind-address':         value => '0.0.0.0';
    'pid-file':             value => '/var/run/mysqld/mysqld.pid';
    'old_passwords':        value => '0';
    'character-set-server': value => 'utf8';
    'log-warnings':         value => '1';
    'datadir':              value => "${mysql::params::data_dir}";
    'max_allowed_packet':   value => '26M',
    'innodb_file_per_table':value => '1',
    'innodb_flush_log_at_trx_commit': value => '0',
    'innodb_flush_method': value => 'O_DSYNC',
    'innodb_buffer_pool_size': value => '32M',
    'innodb_log_buffer_size': value => '8M',
    'innodb_doublewrite': value => '0',
    'innodb_thread_concurrency': value => '4',
    'innodb_open_files': value => '150',
    'transaction-isolation': value => 'READ-UNCOMMITTED',
    'binlog_format': value => 'row',
    'log-error':            value => $::operatingsystem ? {
      /RedHat|Fedora|CentOS/ => '/var/log/mysqld.log',
      default                => '/var/log/mysql.err',
      };
    'log-slow-queries':     value => $::operatingsystem ? {
      /RedHat|Fedora|CentOS/ => '/var/log/mysql-slow-queries.log',
      default                => '/var/log/mysql/mysql-slow.log',
      };
    # "ins log-slow-admin-statements after log-slow-queries", # BUG: not implemented in puppet yet
    'socket':                value => $::operatingsystem ? {
      /RedHat|Fedora|CentOS/ => '/var/lib/mysql/mysql.sock',
      default                => '/var/run/mysqld/mysqld.sock',
      };
  }
}
