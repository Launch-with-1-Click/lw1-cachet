git "/var/www/Cachet" do
  repository node[:lw1_cachet][:install][:repo_url]
  revision node[:lw1_cachet][:install][:version]
  action :checkout
  notifies :run, 'bash[fixup_Cachet_permissions_after_clone]' ,:immediately
end

## apache cannot create dir under /var/www directly.
bash "fixup_Cachet_permissions_after_clone" do
  code <<-EOL
  chown -R #{node[:lw1_cachet][:user]}.#{node[:lw1_cachet][:group]} /var/www/Cachet
  EOL
  action :nothing
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
     /usr/bin/php artisan config:clear
  EOL
  returns [0, 1]
end
