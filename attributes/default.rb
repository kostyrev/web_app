default['web_app']['user']  = 'web_admin'
default['web_app']['group'] = 'web_admin'

default['web_app']['name'] = 'customers'
default['web_app']['config'] = 'customers.conf'

default['apache']['docroot_dir'] = '/srv/apache/customers'

default['web_app']['passwords']['secret_path'] = '/etc/chef/encrypted_data_bag_secret'

default['web_app']['database']['dbname']   = 'products'
default['web_app']['database']['host']     = '127.0.0.1'
default['web_app']['database']['username'] = 'root'

default['web_app']['database']['app']['username'] = 'db_admin'

default['web_app']['database']['seed_file'] = '/tmp/create-tables.sql'

case node['platform_family']
when 'rhel'
  default['web_app']['php-mysql-package'] = 'php-mysql'
when 'debian'
  default['web_app']['php-mysql-package'] = 'php5-mysqlnd'
end
