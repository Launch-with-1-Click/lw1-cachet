default[:lw1_cachet][:user] = 'apache'
default[:lw1_cachet][:group] = 'apache'

## Sum = Sha256
default[:lw1_cachet][:install] = {
  version: '2.1.0',
  checksum: "1eedfdbf387b72d15444ccbc9dcde65dd55859262832833f98ef048fd87826fc",
  base_url: "https://github.com/CachetHQ/Cachet/archive/"
}

default[:lw1_cachet][:install][:download_url] = [
  node[:lw1_cachet][:install][:base_url],
  "v#{node[:lw1_cachet][:install][:version]}.tar.gz"
].join("/")

