ark "Cachet" do
  url node[:lw1_cachet][:install][:download_url]
  version node[:lw1_cachet][:install][:version]
  path "/var/www"
  checksum  node[:lw1_cachet][:install][:checksum]
  owner 'apache'
  group 'apache'
  action :put
end

template "/etc/httpd/conf/httpd.conf" do
  source "httpd/httpd.conf.erb"
end

template "/etc/httpd/conf.d/cachet.conf" do
  source "httpd/cachet.conf.erb"
end

template "/etc/httpd/conf.d/ssl.conf" do
  source "httpd/ssl.conf.erb"
end

bash "execute composer install" do
  cwd "/var/www/Cachet"
  user 'apache'
  group 'apache'
  environment "HOME" => "/home/ec2-user"
  code <<-EOL
     # /usr/local/bin/composer install --no-dev
     /usr/local/bin/composer install --no-dev -o
  EOL
  returns [0, 1]
end
