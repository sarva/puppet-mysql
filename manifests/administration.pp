class mysql::administration (
  $sudo_user = $sudo_mysql_admin_user,
) {

  include ::mysql::common

# TODO:
# - permissions to edit my.cnf once augeas bug is corrected (see
#   modules/cognac/manifests/classes/mysql-slave.pp)
# - .my.cnf for people in %mysql-admin

  $sudo_group = '%mysql-admin'
  $sudo_user_alias = flatten([$sudo_group, $sudo_user])
  $sudo_cmnd = $::osfamily ? {
    'Debian' => '/etc/init.d/mysql',
    'RedHat' => '/etc/init.d/mysqld, /sbin/service mysqld',
  }

  sudo::directive { 'mysql-administration':
    ensure  => present,
    content => template('mysql/sudoers.mysql.erb'),
    require => Group['mysql-admin'],
  }

}
