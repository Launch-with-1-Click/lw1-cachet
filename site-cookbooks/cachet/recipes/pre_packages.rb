## install misc packages

package 'git'
package 'tmux'
package 'postfix'
package 'mysql56-server'

%w[
php56
php56-mysqlnd
php56-gd
php56-mcrypt
php56-mbstring
php56-opcache
].map do |php_m|
  package php_m
end

service 'sendmail' do
  action [:stop, :disable]
end

ruby_block "update php.ini" do
  block do
    _file = Chef::Util::FileEdit.new('/etc/php.ini')
    _file.search_file_replace_line(/^post_max_size/, "post_max_size = 258M ;")
    _file.search_file_replace_line(/^upload_max_filesize/, "upload_max_filesize = 256M ;")
    _file.search_file_replace_line(/^max_execution_time/, "max_execution_time = 600 ;")
    _file.write_file
  end
end

ruby_block "allow postfix unknown_local_recipient_maps" do
  block do
    _file = Chef::Util::FileEdit.new('/etc/postfix/main.cf')
    _file.search_file_replace_line(/^#local_recipient_maps =$/, "local_recipient_maps =")
    _file.write_file
  end
end
