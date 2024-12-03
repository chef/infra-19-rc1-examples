#
# Cookbook:: hello
# Recipe:: cleanup
#
# Cleans up the /tmp/hello directory
#
# Copyright:: 2024 Progress Software Inc
#

directory '/tmp/hello' do
  action :delete
  recursive true
end
