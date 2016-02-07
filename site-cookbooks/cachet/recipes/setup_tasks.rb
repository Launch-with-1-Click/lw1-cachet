directory "/opt/lw1/tasks" do
  action :create
  recursive true
end

template "/opt/lw1/tasks/first_boot.rb" do
  source "tasks/first_boot.erb"
end

cookbook_file "/opt/lw1/tasks/date.ini.erb" do
  source "lw1_tasks/date.ini.erb"
end

cookbook_file "/opt/lw1/tasks/env.example.erb" do
  source "lw1_tasks/env.example.erb"
end

cron "setup_cachet_on_init" do
  action :create
  time :reboot
  command "/opt/chef/bin/chef-apply /opt/lw1/tasks/first_boot.rb > /dev/null 2>&1"
end
